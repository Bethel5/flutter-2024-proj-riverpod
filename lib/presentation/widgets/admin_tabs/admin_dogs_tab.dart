import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pet_pal/application/pets/pet_notifier.dart';
import 'package:flutter_pet_pal/presentation/widgets/admin_pet_tile.dart';

class AdminDogsTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petsState = ref.watch(petNotifierProvider);

    return petsState.when(
      data: (pets) {
        final dogs = pets.where((pet) => pet.category == 'Dog').toList();
        return GridView.builder(
          padding: EdgeInsets.all(12),
          itemCount: dogs.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            return AdminPetTile(
              pet: dogs[index],
            );
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Failed to load pets')),
    );
  }
}