import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../domain/auth/auth_failure.dart';
import '../../domain/auth/auth_repository.dart';
import '../../domain/auth/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final http.Client client;
  final String baseUrl;
  final FlutterSecureStorage secureStorage;

  AuthRepositoryImpl(this.client, this.baseUrl, this.secureStorage);

  @override
  Future<Either<AuthFailure, User>> signIn(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    try {
      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final tokenData = jsonDecode(response.body);

        if (tokenData['access_token'] == null) {
          return left(AuthFailure('Invalid response from server'));
        }

        // Store the token securely
        await secureStorage.write(key: 'access_token', value: tokenData['access_token']);
        

        // Decode the token to extract user details
        final decodedToken = JwtDecoder.decode(tokenData['access_token']);
        final role = decodedToken['role'] as String? ?? 'user'; // Default to 'user' if role is missing

        // Create user with role
        final user = User(id: '1', email: email, fullName: 'Dummy User', role: role);
        return right(user);
      } else {
        return left(AuthFailure('Failed to sign in'));
      }
    } catch (e) {
      print('SignIn Error: $e'); // Log the error
      return left(AuthFailure('Failed to sign in'));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signUp(String fullName, String email, String password) async {
    final url = Uri.parse('$baseUrl/users');
    try {
      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'fullName': fullName, 'email': email, 'password': password}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        return right(unit);
      } else {
        return left(AuthFailure('Failed to sign up'));
      }
    } catch (e) {
      print('SignUp Error: $e'); // Log the error
      return left(AuthFailure('Failed to sign up'));
    }
  }
}
