// import 'package:flutter/material.dart';
// //import '../all_tiles.dart';
// import '../admin_tiles.dart';

// class BunnyTab extends StatelessWidget {
//   // const BunnyTab({super.key});
//   List dogsAvailable = [
//     //[image, name, age, gender, species]
//     [
//       'lib/images/bunny1.jpeg',
//       "Name: Cotton",
//       'Age: 1',
//       'Gender: Male',
//       'Species: Holland Lop',
//     ],
//     [
//       'lib/images/bunny2.jpeg',
//       "Name: Daisy",
//       'Age: 2',
//       'Gender: Female',
//       'Species: Dwarf',
//     ],
//     [
//       'lib/images/bunny3.jpeg',
//       "Name: Thumper",
//       'Age: 3',
//       'Gender: Male',
//       'Species: Mini Rex',
//     ],
//     [
//       'lib/images/bunny4.jpeg',
//       "Name: Clover",
//       'Age: 2.5',
//       'Gender: Female',
//       'Species: Lionhead',
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

class AdminBunnyTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petsState = ref.watch(petNotifierProvider);

    return petsState.when(
      data: (pets) {
        final bunnies = pets.where((pet) => pet.category == 'Bunny').toList();
        return GridView.builder(
          padding: EdgeInsets.all(12),
          itemCount: bunnies.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            return AdminPetTile(
              pet: bunnies[index],
            );
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Failed to load pets')),
    );
  }
}




