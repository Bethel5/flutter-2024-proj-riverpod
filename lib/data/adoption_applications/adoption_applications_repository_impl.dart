// import 'dart:convert';
// import 'package:dartz/dartz.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import '../../domain/adoption_applications/adoption_applications.dart';
// import '../../domain/adoption_applications/adoption_applications_repository.dart';
// import '../../domain/auth/auth_failure.dart';

// class AdoptionRepositoryImpl implements AdoptionRepository {
//   final http.Client client;
//   final String baseUrl;
//   final FlutterSecureStorage secureStorage;

//   AdoptionRepositoryImpl(this.client, this.baseUrl, this.secureStorage);

//   Future<String?> _getToken() async {
//     return await secureStorage.read(key: 'access_token');
//   }

//   Future<String?> _getUserIdFromToken() async {
//     final token = await _getToken();
//     if (token != null) {
//       final decodedToken = JwtDecoder.decode(token);
//       return decodedToken['sub']; // Assuming 'sub' is the user ID
//     }
//     return null;
//   }

//   @override
//   Future<Either<AuthFailure, List<AdoptionApplication>>> fetchApplications() async {
//     final url = Uri.parse('$baseUrl/adoption-applications');
//     final token = await _getToken();
//     try {
//       final response = await client.get(url, headers: {
//         'Authorization': 'Bearer $token',
//       });

//       if (response.statusCode == 200) {
//         final List<dynamic> applicationsJson = jsonDecode(response.body);
//         final applications = applicationsJson.map((json) => AdoptionApplication.fromJson(json)).toList();
//         return right(applications);
//       } else {
//         print('Error: ${response.body}');
//         return left(AuthFailure.serverError());
//       }
//     } catch (e) {
//       print('Network error: $e');
//       return left(AuthFailure.networkError());
//     }
//   }

//   @override
//   Future<Either<AuthFailure, AdoptionApplication>> fetchApplicationById(String id) async {
//     final url = Uri.parse('$baseUrl/adoption-applications/$id');
//     final token = await _getToken();
//     try {
//       final response = await client.get(url, headers: {
//         'Authorization': 'Bearer $token',
//       });

//       if (response.statusCode == 200) {
//         final application = AdoptionApplication.fromJson(jsonDecode(response.body));
//         return right(application);
//       } else {
//         print('Error: ${response.body}');
//         return left(AuthFailure.serverError());
//       }
//     } catch (e) {
//       print('Network error: $e');
//       return left(AuthFailure.networkError());
//     }
//   }

//   @override
//   Future<Either<AuthFailure, Unit>> createApplication(Map<String, dynamic> applicationJson) async {
//     final url = Uri.parse('$baseUrl/adoption-applications');
//     final token = await _getToken();
//     final userId = await _getUserIdFromToken();

//     if (userId != null) {
//       applicationJson['userId'] = userId; // Include user ID in the payload
//     } else {
//       return left(AuthFailure('User ID not found'));
//     }

//     try {
//       final response = await client.post(
//         url,
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(applicationJson),
//       );

//       if (response.statusCode == 201) {
//         return right(unit);
//       } else {
//         print('Error: ${response.body}');
//         return left(AuthFailure('Failed to create application'));
//       }
//     } catch (e) {
//       print('Network error: $e');
//       return left(AuthFailure('Failed to create application'));
//     }
//   }

//   @override
//   Future<Either<AuthFailure, Unit>> updateApplication(String id, AdoptionApplication application) async {
//     final url = Uri.parse('$baseUrl/adoption-applications/$id');
//     final token = await _getToken();
//     try {
//       final response = await client.patch(
//         url,
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(application.toJson()),
//       );

//       if (response.statusCode == 200) {
//         return right(unit);
//       } else {
//         print('Error: ${response.body}');
//         return left(AuthFailure('Failed to update application'));
//       }
//     } catch (e) {
//       print('Network error: $e');
//       return left(AuthFailure('Failed to update application'));
//     }
//   }

//   @override
//   Future<Either<AuthFailure, Unit>> deleteApplication(String id) async {
//     final url = Uri.parse('$baseUrl/adoption-applications/$id');
//     final token = await _getToken();
//     try {
//       final response = await client.delete(
//         url,
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 204) {
//         return right(unit);
//       } else {
//         print('Error: ${response.body}');
//         return left(AuthFailure('Failed to delete application'));
//       }
//     } catch (e) {
//       print('Network error: $e');
//       return left(AuthFailure('Failed to delete application'));
//     }
//   }
// }
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/adoption_applications/adoption_applications.dart';
import '../../domain/adoption_applications/adoption_applications_repository.dart';
import '../../domain/auth/auth_failure.dart';

class AdoptionRepositoryImpl implements AdoptionRepository {
  final http.Client client;
  final String baseUrl;
  final FlutterSecureStorage secureStorage;

  AdoptionRepositoryImpl(this.client, this.baseUrl, this.secureStorage);

  Future<String?> _getToken() async {
    return await secureStorage.read(key: 'access_token');
  }

  @override
  Future<Either<AuthFailure, List<AdoptionApplication>>> fetchApplications() async {
    final url = Uri.parse('$baseUrl/adoption-applications');
    final token = await _getToken();
    print('Token: $token'); // Log the token for debugging
    try {
      final response = await client.get(url, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final List<dynamic> applicationsJson = jsonDecode(response.body);
        final applications = applicationsJson.map((json) => AdoptionApplication.fromJson(json)).toList();
        return right(applications);
      } else {
        print('Error: ${response.body}');
        return left(AuthFailure.serverError());
      }
    } catch (e) {
      print('Network error: $e');
      return left(AuthFailure.networkError());
    }
  }

  Future<Either<AuthFailure, List<AdoptionApplication>>> fetchUserApplications() async {
    final url = Uri.parse('$baseUrl/adoption-applications/me');
    final token = await _getToken();
    print('Token: $token'); // Log the token for debugging
    try {
      final response = await client.get(url, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final List<dynamic> applicationsJson = jsonDecode(response.body);
        final applications = applicationsJson.map((json) => AdoptionApplication.fromJson(json)).toList();
        return right(applications);
      } else {
        print('Error: ${response.body}');
        return left(AuthFailure.serverError());
      }
    } catch (e) {
      print('Network error: $e');
      return left(AuthFailure.networkError());
    }
  }
  @override
  Future<Either<AuthFailure, Unit>> createApplication(Map<String, dynamic> applicationJson) async {
    final url = Uri.parse('$baseUrl/adoption-applications');
    final token = await _getToken();
    print('Token: $token'); // Log the token for debugging
    print('Payload: $applicationJson'); // Log the payload for debugging
    try {
      final response = await client.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(applicationJson),
      );

      if (response.statusCode == 201) {
        return right(unit);
      } else {
        print('Error: ${response.body}');
        return left(AuthFailure('Failed to create application'));
      }
    } catch (e) {
      print('Network error: $e');
      return left(AuthFailure('Failed to create application'));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> updateApplication(String id, AdoptionApplication application) async {
    final url = Uri.parse('$baseUrl/adoption-applications/$id');
    final token = await _getToken();
    print('Token: $token'); // Log the token for debugging
    try {
      final response = await client.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(application.toJson()),
      );

      if (response.statusCode == 200) {
        return right(unit);
      } else {
        print('Error: ${response.body}');
        return left(AuthFailure('Failed to update application'));
      }
    } catch (e) {
      print('Network error: $e');
      return left(AuthFailure('Failed to update application'));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> deleteApplication(String id) async {
    final url = Uri.parse('$baseUrl/adoption-applications/$id');
    final token = await _getToken();
    print('Token: $token'); // Log the token for debugging
    try {
      final response = await client.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 204) {
        return right(unit);
      } else {
        print('Error: ${response.body}');
        return left(AuthFailure('Failed to delete application'));
      }
    } catch (e) {
      print('Network error: $e');
      return left(AuthFailure('Failed to delete application'));
    }
  }
  
  @override
  Future<Either<AuthFailure, AdoptionApplication>> fetchApplicationById(String id) {
    // TODO: implement fetchApplicationById
    throw UnimplementedError();
  }
}

