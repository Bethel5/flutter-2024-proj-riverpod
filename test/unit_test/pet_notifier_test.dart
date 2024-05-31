// ignore_for_file: unused_import

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_pet_pal/domain/pets/pet.dart';
import 'package:flutter_pet_pal/domain/auth/auth_failure.dart';
import 'package:flutter_pet_pal/domain/pets/pet_repository.dart';
import 'package:flutter_pet_pal/application/pets/pet_notifier.dart';
import 'package:flutter_pet_pal/application/auth/providers.dart';

@GenerateMocks([PetRepository])
import 'pet_notifier_test.mocks.dart';

void main() {
  late MockPetRepository mockPetRepository;
  late ProviderContainer container;

  setUp(() {
    mockPetRepository = MockPetRepository();
    container = ProviderContainer(overrides: [
      petRepositoryProvider.overrideWithValue(mockPetRepository),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  final testPets = [
    Pet(
      id: '1',
      name: 'Buddy',
      age: 3,
      species: 'Dog',
      gender: 'Male',
      description: 'Friendly dog',
      image: 'dog.jpg',
      category: 'Adoption',
    ),
  ];

  test('fetchPets success', () async {
    when(mockPetRepository.fetchPets())
        .thenAnswer((_) async => right(testPets));

    final notifier = container.read(petNotifierProvider.notifier);
    await notifier.fetchPets();

    final state = container.read(petNotifierProvider);
    expect(state, AsyncValue.data(testPets));
  });

  test('fetchPets failure', () async {
    when(mockPetRepository.fetchPets())
        .thenAnswer((_) async => left(AuthFailure('Failed to fetch pets')));

    final notifier = container.read(petNotifierProvider.notifier);
    await notifier.fetchPets();

    final state = container.read(petNotifierProvider);
    expect(state, isA<AsyncError>());
  });

  test('addPet success', () async {
    final newPet = Pet(
      id: '2',
      name: 'Kitty',
      age: 2,
      species: 'Cat',
      gender: 'Female',
      description: 'Cute cat',
      image: 'cat.jpg',
      category: 'Adoption',
    );

    when(mockPetRepository.addPet(any))
        .thenAnswer((_) async => right(unit));

    when(mockPetRepository.fetchPets())
        .thenAnswer((_) async => right([...testPets, newPet]));

    final notifier = container.read(petNotifierProvider.notifier);
    await notifier.addPet(newPet);

    final state = container.read(petNotifierProvider);
    expect(state, isA<AsyncData<List<Pet>>>());
    expect(state.value!.length, equals(2));
  });

  test('addPet failure', () async {
    final newPet = Pet(
      id: '2',
      name: 'Kitty',
      age: 2,
      species: 'Cat',
      gender: 'Female',
      description: 'Cute cat',
      image: 'cat.jpg',
      category: 'Adoption',
    );

    when(mockPetRepository.addPet(any))
        .thenAnswer((_) async => left(AuthFailure('Failed to add pet')));

    final notifier = container.read(petNotifierProvider.notifier);
    await notifier.addPet(newPet);

    final state = container.read(petNotifierProvider);
    expect(state, isA<AsyncError>());
  });

  test('updatePet success', () async {
    final updatedPet = testPets.first.copyWith(name: 'Buddy Updated');

    when(mockPetRepository.updatePet(any, any))
        .thenAnswer((_) async => right(unit));

    when(mockPetRepository.fetchPets())
        .thenAnswer((_) async => right([updatedPet]));

    final notifier = container.read(petNotifierProvider.notifier);
    await notifier.updatePet(updatedPet.id, updatedPet);

    final state = container.read(petNotifierProvider);
    expect(state, isA<AsyncData<List<Pet>>>());
    expect(state.value!.first.name, equals('Buddy Updated'));
  });

  test('updatePet failure', () async {
    final updatedPet = testPets.first.copyWith(name: 'Buddy Updated');

    when(mockPetRepository.updatePet(any, any))
        .thenAnswer((_) async => left(AuthFailure('Failed to update pet')));

    final notifier = container.read(petNotifierProvider.notifier);
    await notifier.updatePet(updatedPet.id, updatedPet);

    final state = container.read(petNotifierProvider);
    expect(state, isA<AsyncError>());
  });

  test('deletePet success', () async {
    when(mockPetRepository.deletePet(any))
        .thenAnswer((_) async => right(unit));

    when(mockPetRepository.fetchPets())
        .thenAnswer((_) async => right([]));

    final notifier = container.read(petNotifierProvider.notifier);
    await notifier.deletePet(testPets.first.id);

    final state = container.read(petNotifierProvider);
    expect(state, isA<AsyncData<List<Pet>>>());
    expect(state.value, isEmpty);
  });

  test('deletePet failure', () async {
    when(mockPetRepository.deletePet(any))
        .thenAnswer((_) async => left(AuthFailure('Failed to delete pet')));

    final notifier = container.read(petNotifierProvider.notifier);
    await notifier.deletePet(testPets.first.id);

    final state = container.read(petNotifierProvider);
    expect(state, isA<AsyncError>());
  });
}
