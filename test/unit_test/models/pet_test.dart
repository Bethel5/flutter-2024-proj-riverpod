import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pet_pal/domain/pets/pet.dart';

void main() {
  group('Pet model', () {
    final petJson = {
      '_id': '1',
      'name': 'Fido',
      'age': 2,
      'species': 'Dog',
      'gender': 'Male',
      'description': 'Friendly dog',
      'image': '',
      'category': 'Dog',
    };

    final pet = Pet(
      id: '1',
      name: 'Fido',
      age: 2,
      species: 'Dog',
      gender: 'Male',
      description: 'Friendly dog',
      image: '',
      category: 'Dog',
    );


    test('toJson converts Pet object to JSON', () {
      expect(pet.toJson(), petJson);
    });

    test('copyWith creates a copy with updated values', () {
      final updatedPet = pet.copyWith(name: 'Rex');
      expect(updatedPet.name, 'Rex');
      expect(updatedPet.id, pet.id); 
    });
  });
}
