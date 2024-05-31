import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'pet.dart';
import '../auth/auth_failure.dart';

abstract class PetRepository {
  Future<Either<AuthFailure, List<Pet>>> fetchPets();
  Future<Either<AuthFailure, Pet>> fetchPetById(String id);
  Future<Either<AuthFailure, Unit>> addPet(Pet pet, {File? imageFile, Uint8List? webImage});
  Future<Either<AuthFailure, Unit>> updatePet(String id, Pet updatedPet);
  Future<Either<AuthFailure, Unit>> deletePet(String id);
}
