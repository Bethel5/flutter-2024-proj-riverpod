import 'package:flutter_pet_pal/domain/pets/pet.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Pet', () {
    test('fromJson creates Pet from valid JSON', () {
      final json = {
        '_id': '1',
        'name': 'Buddy',
        'age': 3,
        'species': 'Dog',
        'gender': 'Male',
        'description': 'Friendly dog',
        'image': 'buddy.jpg',
        'category': 'Mammal',
      };

      final pet = Pet.fromJson(json);

      expect(pet.id, '1');
      expect(pet.name, 'Buddy');
      expect(pet.age, 3);
      expect(pet.species, 'Dog');
      expect(pet.gender, 'Male');
      expect(pet.description, 'Friendly dog');
      expect(pet.image, 'buddy.jpg');
      expect(pet.category, 'Mammal');
    });

    test('fromJson handles missing fields', () {
      final json = {
        '_id': '1',
        'name': 'Buddy',
        'age': 3,
        'species': 'Dog',
      };

      final pet = Pet.fromJson(json);

      expect(pet.id, '1');
      expect(pet.name, 'Buddy');
      expect(pet.age, 3);
      expect(pet.species, 'Dog');
      expect(pet.gender, '');
      expect(pet.description, '');
      expect(pet.image, '');
      expect(pet.category, '');
    });

    test('toJson converts Pet to JSON', () {
      final pet = Pet(
        id: '1',
        name: 'Buddy',
        age: 3,
        species: 'Dog',
        gender: 'Male',
        description: 'Friendly dog',
        image: 'buddy.jpg',
        category: 'Mammal',
      );

      final json = pet.toJson();

      expect(json['_id'], '1');
      expect(json['name'], 'Buddy');
      expect(json['age'], 3);
      expect(json['species'], 'Dog');
      expect(json['gender'], 'Male');
      expect(json['description'], 'Friendly dog');
      expect(json['image'], 'buddy.jpg');
      expect(json['category'], 'Mammal');
    });

    test('copyWith creates a copy with updated fields', () {
      final pet = Pet(
        id: '1',
        name: 'Buddy',
        age: 3,
        species: 'Dog',
        gender: 'Male',
        description: 'Friendly dog',
        image: 'buddy.jpg',
        category: 'Mammal',
      );

      final updatedPet = pet.copyWith(name: 'Buddy Jr.', age: 4);

      expect(updatedPet.id, '1');
      expect(updatedPet.name, 'Buddy Jr.');
      expect(updatedPet.age, 4);
      expect(updatedPet.species, 'Dog');
      expect(updatedPet.gender, 'Male');
      expect(updatedPet.description, 'Friendly dog');
      expect(updatedPet.image, 'buddy.jpg');
      expect(updatedPet.category, 'Mammal');
    });
  });
}
