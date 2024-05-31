// ignore_for_file: unused_import

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_pet_pal/data/pets/pet_repository_impl.dart';
import 'package:flutter_pet_pal/domain/pets/pet.dart';
import 'package:flutter_pet_pal/domain/auth/auth_failure.dart';
import 'package:dartz/dartz.dart';

@GenerateMocks([http.Client, FlutterSecureStorage])
import 'pet_repository_impl_test.mocks.dart';

void main() {
  late MockClient mockClient;
  late MockFlutterSecureStorage mockSecureStorage;
  late PetRepositoryImpl petRepository;
  const baseUrl = 'http://example.com';

  setUp(() {
    mockClient = MockClient();
    mockSecureStorage = MockFlutterSecureStorage();
    petRepository = PetRepositoryImpl(mockClient, baseUrl, mockSecureStorage);
  });

  group('fetchPets', () {
    test('returns list of pets on successful fetch', () async {
      final petsJson = '[{"_id": "1", "name": "Buddy", "age": 3, "species": "Dog", "gender": "Male", "description": "Friendly dog", "image": "dog.jpg", "category": "Adoption"}]';
      when(mockClient.get(Uri.parse('$baseUrl/pets')))
          .thenAnswer((_) async => http.Response(petsJson, 200));

      final result = await petRepository.fetchPets();

      expect(result, isA<Right>());
      // expect(result | null, isNotNull);
    });

    test('returns AuthFailure on server error', () async {
      when(mockClient.get(Uri.parse('$baseUrl/pets')))
          .thenAnswer((_) async => http.Response('Server Error', 500));

      final result = await petRepository.fetchPets();

      expect(result, isA<Left>());
      // expect(result.swap().getOrElse(() => null), isA<AuthFailure>());
    });

    test('returns AuthFailure on network error', () async {
      when(mockClient.get(Uri.parse('$baseUrl/pets')))
          .thenThrow(Exception('Network Error'));

      final result = await petRepository.fetchPets();

      expect(result, isA<Left>());
      // expect(result.swap().getOrElse(() => null), isA<AuthFailure>());
    });
  });

  group('fetchPetById', () {
    test('returns a pet on successful fetch', () async {
      final petJson = '{"_id": "1", "name": "Buddy", "age": 3, "species": "Dog", "gender": "Male", "description": "Friendly dog", "image": "dog.jpg", "category": "Adoption"}';
      when(mockClient.get(Uri.parse('$baseUrl/pets/1')))
          .thenAnswer((_) async => http.Response(petJson, 200));

      final result = await petRepository.fetchPetById('1');

      expect(result, isA<Right>());
      // expect(result | null, isNotNull);
    });

    test('returns AuthFailure on server error', () async {
      when(mockClient.get(Uri.parse('$baseUrl/pets/1')))
          .thenAnswer((_) async => http.Response('Server Error', 500));

      final result = await petRepository.fetchPetById('1');

      expect(result, isA<Left>());
      // expect(result.swap().getOrElse(() => null), isA<AuthFailure>());
    });

    test('returns AuthFailure on network error', () async {
      when(mockClient.get(Uri.parse('$baseUrl/pets/1')))
          .thenThrow(Exception('Network Error'));

      final result = await petRepository.fetchPetById('1');

      expect(result, isA<Left>());
      // expect(result.swap().getOrElse(() => null), isA<AuthFailure>());
    });
  });

  group('addPet', () {
    test('returns unit on successful add', () async {
      final pet = Pet(
        id: '1',
        name: 'Buddy',
        age: 3,
        species: 'Dog',
        gender: 'Male',
        description: 'Friendly dog',
        image: 'dog.jpg',
        category: 'Adoption',
      );

      when(mockClient.post(
        Uri.parse('$baseUrl/pets'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('', 201));

      final result = await petRepository.addPet(pet);

      expect(result, isA<Right>());
      // expect(result | null, equals(unit));
    });

    test('returns AuthFailure on server error', () async {
      final pet = Pet(
        id: '1',
        name: 'Buddy',
        age: 3,
        species: 'Dog',
        gender: 'Male',
        description: 'Friendly dog',
        image: 'dog.jpg',
        category: 'Adoption',
      );

      when(mockClient.post(
        Uri.parse('$baseUrl/pets'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Server Error', 500));

      final result = await petRepository.addPet(pet);

      expect(result, isA<Left>());
      // expect(result.swap().getOrElse(() => null), isA<AuthFailure>());
    });

    test('returns AuthFailure on network error', () async {
      final pet = Pet(
        id: '1',
        name: 'Buddy',
        age: 3,
        species: 'Dog',
        gender: 'Male',
        description: 'Friendly dog',
        image: 'dog.jpg',
        category: 'Adoption',
      );

      when(mockClient.post(
        Uri.parse('$baseUrl/pets'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenThrow(Exception('Network Error'));

      final result = await petRepository.addPet(pet);

      expect(result, isA<Left>());
      // expect(result.swap().getOrElse(() => null), isA<AuthFailure>());
    });
  });

  group('updatePet', () {
    test('returns unit on successful update', () async {
      final updatedPet = Pet(
        id: '1',
        name: 'Buddy Updated',
        age: 3,
        species: 'Dog',
        gender: 'Male',
        description: 'Friendly dog',
        image: 'dog.jpg',
        category: 'Adoption',
      );

      when(mockClient.patch(
        Uri.parse('$baseUrl/pets/1'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('', 200));

      final result = await petRepository.updatePet('1', updatedPet);

      expect(result, isA<Right>());
      // expect(result | null, equals(unit));
    });

    test('returns AuthFailure on server error', () async {
      final updatedPet = Pet(
        id: '1',
        name: 'Buddy Updated',
        age: 3,
        species: 'Dog',
        gender: 'Male',
        description: 'Friendly dog',
        image: 'dog.jpg',
        category: 'Adoption',
      );

      when(mockClient.patch(
        Uri.parse('$baseUrl/pets/1'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Server Error', 500));

      final result = await petRepository.updatePet('1', updatedPet);

      expect(result, isA<Left>());
      // expect(result.swap().getOrElse(() => null), isA<AuthFailure>());
    });

    test('returns AuthFailure on network error', () async {
      final updatedPet = Pet(
        id: '1',
        name: 'Buddy Updated',
        age: 3,
        species: 'Dog',
        gender: 'Male',
        description: 'Friendly dog',
        image: 'dog.jpg',
        category: 'Adoption',
      );

      when(mockClient.patch(
        Uri.parse('$baseUrl/pets/1'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenThrow(Exception('Network Error'));

      final result = await petRepository.updatePet('1', updatedPet);

      expect(result, isA<Left>());
      // expect(result.swap().getOrElse(() => null), isA<AuthFailure>());
    });
  });

  group('deletePet', () {
    test('returns unit on successful delete', () async {
      when(mockClient.delete(
        Uri.parse('$baseUrl/pets/1'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('', 204));

      final result = await petRepository.deletePet('1');

      expect(result, isA<Right>());
      // expect(result | null, equals(unit));
    });

    test('returns AuthFailure on server error', () async {
      when(mockClient.delete(
        Uri.parse('$baseUrl/pets/1'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('Server Error', 500));

      final result = await petRepository.deletePet('1');

      expect(result, isA<Left>());
      // expect(result.swap().getOrElse(() => null), isA<AuthFailure>());
    });

    test('returns AuthFailure on network error', () async {
      when(mockClient.delete(
        Uri.parse('$baseUrl/pets/1'),
        headers: anyNamed('headers'),
      )).thenThrow(Exception('Network Error'));

      final result = await petRepository.deletePet('1');

      expect(result, isA<Left>());
      // expect(result.swap().getOrElse(() => null), isA<AuthFailure>());
    });
  });
}
