// import 'package:flutter/material.dart';
// //import '../all_tiles.dart';
// import '../admin_tiles.dart';

// class CatsTab extends StatelessWidget {
//   // const CatsTab({super.key});\
//   List dogsAvailable = [
//     //[image, name, age, gender, species]
//     [
//       'lib/images/cat1.jpeg',
//       "Name: Simba",
//       'Age: 2',
//       'Gender: Male',
//       'Species: Siamese',
//     ],
//     [
//       'lib/images/cat2.jpeg',
//       "Name: Luna",
//       'Age: 3',
//       'Gender: Female',
//       'Species: Persian',
//     ],
//     [
//       'lib/images/cat3.jpeg',
//       "Name: Oliver",
//       'Age: 4',
//       'Gender: Male',
//       'Species: Maine Coon',
//     ],
//     [
//       'lib/images/cat4.jpeg',
//       "Name: Bella",
//       'Age: 1',
//       'Gender: Female',
//       'Species: Ragdoll',
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


// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pet_pal/application/pets/pet_notifier.dart';
import 'package:flutter_pet_pal/presentation/widgets/admin_pet_tile.dart';

class AdminCatsTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petsState = ref.watch(petNotifierProvider);

    return petsState.when(
      data: (pets) {
        final cats = pets.where((pet) => pet.category == 'Cat').toList();
        return GridView.builder(
          padding: EdgeInsets.all(12),
          itemCount: cats.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            return AdminPetTile(
              pet: cats[index],
            );
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Failed to load pets')),
    );
  }
}
