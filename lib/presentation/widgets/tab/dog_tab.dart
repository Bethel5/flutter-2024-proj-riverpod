// import 'package:flutter/material.dart';
// import 'package:flutter_pet_pal/presentation/widgets/all_tiles.dart';

// class DogsTab extends StatelessWidget {
//   List dogsAvailable = [
//     //[image, name, age, gender, species]
//     [
//       'lib/images/dog1.jpeg',
//       "Name: Max",
//       'Age: 3',
//       'Gender: Male',
//       'Species: Labrador Retriever',
//     ],
//     [
//       'lib/images/dog2.jpeg',
//       "Name :Luna",
//       'Age: 2',
//       'Gender: Female',
//       'Species: German Shepherd',
//     ],
//     [
//       'lib/images/dog3.jpeg',
//       "Name: Bobby",
//       'Age: 5',
//       'Gender: Male',
//       'Species: Golden Retriever',
//     ],
//     [
//       'lib/images/dog4.jpeg',
//       "Name: Daisy",
//       'Age: 1',
//       'Gender: Female',
//       'Species: Bulldog',
//     ],
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
      
//       padding: EdgeInsets.all(12),
//       itemCount: dogsAvailable.length,

//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, childAspectRatio: 0.5),
//       itemBuilder: (context, index) {
//         return AllTile(
//           imagePath: dogsAvailable[index][0],
//           name: dogsAvailable[index][1],
//           age: dogsAvailable[index][2],
//           gender: dogsAvailable[index][3],
//           species: dogsAvailable[index][4],
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_pet_pal/presentation/widgets/all_tiles.dart';
// import '../../../domain/pets/pet.dart';

// class DogsTab extends StatelessWidget {
//   final List<Pet> pets;

//   const DogsTab({Key? key, required this.pets}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       padding: const EdgeInsets.all(12),
//       itemCount: pets.length,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, childAspectRatio: 0.5),
//       itemBuilder: (context, index) {
//         final pet = pets[index];
//         return AllTile(
//           imagePath: pet.image,
//           name: 'Name: ${pet.name}',
//           age: 'Age: ${pet.age}',
//           gender: 'Gender: ${pet.gender}',
//           species: 'Species: ${pet.species}',
//         );
//       },
//     );
//   }
// }

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

