// ignore_for_file: unused_import

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_pet_pal/application/auth/providers.dart';
import 'package:flutter_pet_pal/data/pets/pet_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pet_pal/domain/pets/pet.dart';
import 'package:flutter_pet_pal/domain/pets/pet_repository.dart';
import 'package:flutter_pet_pal/domain/auth/auth_failure.dart';
import 'package:dartz/dartz.dart';

class PetNotifier extends StateNotifier<AsyncValue<List<Pet>>> {
  final PetRepository _petRepository;

  PetNotifier(this._petRepository) : super(const AsyncValue.loading()) {
    fetchPets();
  }

  Future<void> fetchPets() async {
    final failureOrPets = await _petRepository.fetchPets();
    state = failureOrPets.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (pets) => AsyncValue.data(pets),
    );
  }

  Future<void> addPet(Pet pet, {File? imageFile, Uint8List? webImage}) async {
    final failureOrSuccess = await _petRepository.addPet(pet, imageFile: imageFile, webImage: webImage);
    failureOrSuccess.fold(
      (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
      (_) => fetchPets(),
    );
  }

  Future<void> updatePet(String id, Pet updatedPet) async {
    final failureOrSuccess = await _petRepository.updatePet(id, updatedPet);
    failureOrSuccess.fold(
      (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
      (_) => fetchPets(),
    );
  }

  // Future<void> deletePet(String id) async {
  //   final failureOrSuccess = await _petRepository.deletePet(id);
  //   failureOrSuccess.fold(
  //     (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
  //     (_) => fetchPets(),
  //   );
  // }
  Future<void> deletePet(String id) async {
    final failureOrSuccess = await _petRepository.deletePet(id);
    failureOrSuccess.fold(
      (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
      (_) => fetchPets(),  // Refresh the pets list after deleting a pet
    );
  }
}

final petRepositoryProvider = Provider<PetRepository>((ref) {
  final client = ref.read(httpClientProvider);
  final baseUrl = ref.read(baseUrlProvider);
  final secureStorage = ref.read(secureStorageProvider);
  return PetRepositoryImpl(client, baseUrl, secureStorage);
});

final petNotifierProvider = StateNotifierProvider<PetNotifier, AsyncValue<List<Pet>>>((ref) {
  final petRepository = ref.read(petRepositoryProvider);
  return PetNotifier(petRepository);
});
