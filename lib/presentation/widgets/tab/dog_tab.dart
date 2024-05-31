import 'package:flutter/material.dart';
import 'package:flutter_pet_pal/presentation/widgets/all_tiles.dart';
import '../../../domain/pets/pet.dart';

class DogsTab extends StatelessWidget {
  final List<Pet> pets;

  const DogsTab({Key? key, required this.pets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: pets.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75, // Adjusted aspect ratio for better display
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final pet = pets[index];
        print('Image URL: ${pet.image}');
        return AllTile(
          imagePath: pet.image,
          name: 'Name: ${pet.name}',
          age: 'Age: ${pet.age}',
          gender: 'Gender: ${pet.gender}',
          species: 'Species: ${pet.species}',
        );
      },
    );
  }
}