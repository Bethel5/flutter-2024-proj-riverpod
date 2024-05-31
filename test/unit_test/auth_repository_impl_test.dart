// ignore_for_file: unused_import

import 'package:flutter_test/flutter_test.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_pet_pal/data/auth/auth_repository_impl.dart';
import 'package:flutter_pet_pal/domain/auth/auth_failure.dart';
import 'package:flutter_pet_pal/domain/auth/user.dart';
import 'package:dartz/dartz.dart';
import 'dart:convert';

@GenerateMocks([http.Client, FlutterSecureStorage])
import 'auth_repository_impl_test.mocks.dart';

void main() {
  late MockClient mockClient;
  late MockFlutterSecureStorage mockSecureStorage;
  late AuthRepositoryImpl authRepository;
  const baseUrl = 'http://localhost:3000';

  setUp(() {
    mockClient = MockClient();
    mockSecureStorage = MockFlutterSecureStorage();
    authRepository = AuthRepositoryImpl(mockClient, baseUrl, mockSecureStorage);
  });

  group('signIn', () {
    test('returns AuthFailure on server error', () async {
      when(mockClient.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Server Error', 500));

      final result = await authRepository.signIn('test@example.com', 'password');

      expect(result, isA<Left>());
      
    });

    test('returns AuthFailure on network error', () async {
      when(mockClient.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenThrow(Exception('Network Error'));

      final result = await authRepository.signIn('test@example.com', 'password');

      expect(result, isA<Left>());
      
    });
  });

  group('signUp', () {
    test('returns unit on successful signUp', () async {
      when(mockClient.post(
        Uri.parse('$baseUrl/users'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('', 201));

      final result = await authRepository.signUp('Test User', 'test@example.com', 'password');

      expect(result, isA<Right>());
      
    });

    test('returns AuthFailure on server error', () async {
      when(mockClient.post(
        Uri.parse('$baseUrl/users'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Server Error', 500));

      final result = await authRepository.signUp('Test User', 'test@example.com', 'password');

      expect(result, isA<Left>());
      
    });

    test('returns AuthFailure on network error', () async {
      when(mockClient.post(
        Uri.parse('$baseUrl/users'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenThrow(Exception('Network Error'));

      final result = await authRepository.signUp('Test User', 'test@example.com', 'password');

      expect(result, isA<Left>());
      
    });
  });
}
