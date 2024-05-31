import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_parser/http_parser.dart';
import '../../domain/pets/pet.dart';
import '../../domain/pets/pet_repository.dart';
import '../../domain/auth/auth_failure.dart';
import 'package:mime/mime.dart';

class PetRepositoryImpl implements PetRepository {
  final http.Client client;
  final String baseUrl;
  final FlutterSecureStorage secureStorage;

  PetRepositoryImpl(this.client, this.baseUrl, this.secureStorage);

  Future<String?> _getToken() async {
    return await secureStorage.read(key: 'access_token'); // Ensure the key is correct
  }

  @override
  Future<Either<AuthFailure, List<Pet>>> fetchPets() async {
    final url = Uri.parse('$baseUrl/pets');
    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> petsJson = jsonDecode(response.body);
        final pets = petsJson.map((json) => Pet.fromJson(json)).map((pet) {
          pet = pet.copyWith(image: '$baseUrl/${pet.image}');
          return pet;
        }).toList();
        return right(pets);
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
  Future<Either<AuthFailure, Pet>> fetchPetById(String id) async {
    final url = Uri.parse('$baseUrl/pets/$id');
    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final pet = Pet.fromJson(jsonDecode(response.body));
        return right(pet);
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
  Future<Either<AuthFailure, Unit>> addPet(Pet pet, {File? imageFile, Uint8List? webImage}) async {
    final url = Uri.parse('$baseUrl/pets');
    final token = await _getToken();
    try {
      final request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['name'] = pet.name
        ..fields['age'] = pet.age.toString()
        ..fields['species'] = pet.species
        ..fields['gender'] = pet.gender
        ..fields['description'] = pet.description
        ..fields['category'] = pet.category;

      if (imageFile != null) {
        final mimeType = lookupMimeType(imageFile.path)!.split('/');
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          contentType: MediaType(mimeType[0], mimeType[1]),
        ));
      } else if (webImage != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image',
          webImage,
          filename: 'image.jpg',
          contentType: MediaType('image', 'jpeg'),
        ));
      }

      final response = await request.send();

      if (response.statusCode == 201) {
        return right(unit);
      } else {
        final responseData = await http.Response.fromStream(response);
        print('Error: ${responseData.body}');
        return left(AuthFailure('Failed to add pet'));
      }
    } catch (e) {
      print('Network error: $e');
      return left(AuthFailure('Failed to add pet'));
    }
  }

  @override
  // Future<Either<AuthFailure, Unit>> updatePet(String id, Pet updatedPet) async {
  //   final url = Uri.parse('$baseUrl/pets/$id');
  //   final token = await _getToken();
  //   try {
  //     final response = await client.patch(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: jsonEncode(updatedPet.toJson()),
  //     );

  //     if (response.statusCode == 200) {
  //       return right(unit);
  //     } else {
  //       print('Error: ${response.body}');
  //       return left(AuthFailure.serverError());
  //     }
  //   } catch (e) {
  //     print('Network error: $e');
  //     return left(AuthFailure.networkError());
  //   }
  // }
  Future<Either<AuthFailure, Unit>> updatePet(String id, Pet updatedPet, {File? imageFile, Uint8List? webImage}) async {
    final url = Uri.parse('$baseUrl/pets/$id');
    final token = await _getToken();
    try {
      final request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['name'] = updatedPet.name
        ..fields['age'] = updatedPet.age.toString()
        ..fields['species'] = updatedPet.species
        ..fields['gender'] = updatedPet.gender
        ..fields['description'] = updatedPet.description
        ..fields['category'] = updatedPet.category;

      if (imageFile != null) {
        final mimeType = lookupMimeType(imageFile.path)!.split('/');
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          contentType: MediaType(mimeType[0], mimeType[1]),
        ));
      } else if (webImage != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image',
          webImage,
          filename: 'image.jpg',
          contentType: MediaType('image', 'jpeg'),
        ));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        return right(unit);
      } else {
        final responseData = await http.Response.fromStream(response);
        print('Error: ${responseData.body}');
        return left(AuthFailure('Failed to update pet'));
      }
    } catch (e) {
      print('Network error: $e');
      return left(AuthFailure('Failed to update pet'));
    }
  }


  @override
  // Future<Either<AuthFailure, Unit>> deletePet(String id) async {
  //   final url = Uri.parse('$baseUrl/pets/$id');
  //   final token = await _getToken();
  //   try {
  //     final response = await client.delete(
  //       url,
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 204) {
  //       return right(unit);
  //     } else {
  //       print('Error: ${response.body}');
  //       return left(AuthFailure.serverError());
  //     }
  //   } catch (e) {
  //     print('Network error: $e');
  //     return left(AuthFailure.networkError());
  //   }
  // }
  // Future<Either<AuthFailure, Unit>> deletePet(String id) async {
  //   final url = Uri.parse('$baseUrl/pets/$id');
  //   final token = await _getToken();
  //   try {
  //     final response = await client.delete(
  //       url,
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 204) {
  //       return right(unit);
  //     } else {
  //       print('Error: ${response.body}');
  //       return left(AuthFailure.serverError());
  //     }
  //   } catch (e) {
  //     print('Network error: $e');
  //     return left(AuthFailure.networkError());
  //   }
  // }
  Future<Either<AuthFailure, Unit>> deletePet(String id) async {
    final url = Uri.parse('$baseUrl/pets/$id');
    final token = await _getToken();
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
        return left(AuthFailure('Failed to delete pet'));
      }
    } catch (e) {
      print('Network error: $e');
      return left(AuthFailure('Failed to delete pet'));
    }
  }
}
