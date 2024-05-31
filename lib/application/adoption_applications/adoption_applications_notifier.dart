// // ignore_for_file: unused_import

// import 'package:flutter_pet_pal/application/auth/providers.dart';
// import 'package:flutter_pet_pal/data/adoption_applications/adoption_applications_repository_impl.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_pet_pal/domain/adoption_applications/adoption_applications.dart';
// import 'package:flutter_pet_pal/domain/adoption_applications/adoption_applications_repository.dart';
// import 'package:flutter_pet_pal/domain/auth/auth_failure.dart';
// import 'package:dartz/dartz.dart';

// class AdoptionNotifier extends StateNotifier<AsyncValue<List<AdoptionApplication>>> {
//   final AdoptionRepository _adoptionRepository;

//   AdoptionNotifier(this._adoptionRepository) : super(const AsyncValue.loading());

//   Future<void> fetchApplications() async {
//     final failureOrApplications = await _adoptionRepository.fetchApplications();
//     state = failureOrApplications.fold(
//       (failure) => AsyncValue.error(failure.message, StackTrace.current),
//       (applications) => AsyncValue.data(applications),
//     );
//   }

//   Future<void> createApplication(Map<String, dynamic> applicationJson) async {
//     final failureOrSuccess = await _adoptionRepository.createApplication(applicationJson);
//     failureOrSuccess.fold(
//       (failure) {
//         print('Failed to create application: ${failure.message}');
//         state = AsyncValue.error(failure.message, StackTrace.current);
//       },
//       (_) => fetchApplications(),
//     );
//   }

//   Future<void> updateApplication(String id, AdoptionApplication application) async {
//     final failureOrSuccess = await _adoptionRepository.updateApplication(id, application);
//     failureOrSuccess.fold(
//       (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
//       (_) => fetchApplications(),
//     );
//   }

//   Future<void> deleteApplication(String id) async {
//     final failureOrSuccess = await _adoptionRepository.deleteApplication(id);
//     failureOrSuccess.fold(
//       (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
//       (_) => fetchApplications(),
//     );
//   }
// }

// final adoptionRepositoryProvider = Provider<AdoptionRepository>((ref) {
//   final client = ref.read(httpClientProvider);
//   final baseUrl = ref.read(baseUrlProvider);
//   final secureStorage = ref.read(secureStorageProvider);
//   return AdoptionRepositoryImpl(client, baseUrl, secureStorage);
// });

// final adoptionNotifierProvider = StateNotifierProvider<AdoptionNotifier, AsyncValue<List<AdoptionApplication>>>((ref) {
//   final adoptionRepository = ref.read(adoptionRepositoryProvider);
//   return AdoptionNotifier(adoptionRepository);
// });
// ignore_for_file: unused_import

import 'package:flutter_pet_pal/application/auth/providers.dart';
import 'package:flutter_pet_pal/data/adoption_applications/adoption_applications_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pet_pal/domain/adoption_applications/adoption_applications.dart';
import 'package:flutter_pet_pal/domain/adoption_applications/adoption_applications_repository.dart';
import 'package:flutter_pet_pal/domain/auth/auth_failure.dart';
import 'package:dartz/dartz.dart';

class AdoptionNotifier extends StateNotifier<AsyncValue<List<AdoptionApplication>>> {
  final AdoptionRepository _adoptionRepository;

  AdoptionNotifier(this._adoptionRepository) : super(const AsyncValue.loading()) {
    fetchApplications();
  }

  Future<void> fetchApplications() async {
    final failureOrApplications = await _adoptionRepository.fetchUserApplications();
    state = failureOrApplications.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (applications) => AsyncValue.data(applications),
    );
  }

  Future<void> fetchUserApplications() async {
    final failureOrApplications = await _adoptionRepository.fetchUserApplications();
    state = failureOrApplications.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (applications) => AsyncValue.data(applications),
    );
  }

  Future<void> createApplication(Map<String, dynamic> applicationJson) async {
    final failureOrSuccess = await _adoptionRepository.createApplication(applicationJson);
    failureOrSuccess.fold(
      (failure) {
        print('Failed to create application: ${failure.message}');
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
      (_) => fetchApplications(),
    );
  }

  Future<void> updateApplication(String id, AdoptionApplication application) async {
    final failureOrSuccess = await _adoptionRepository.updateApplication(id, application);
    failureOrSuccess.fold(
      (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
      (_) => fetchApplications(),
    );
  }

  Future<void> deleteApplication(String id) async {
    final failureOrSuccess = await _adoptionRepository.deleteApplication(id);
    failureOrSuccess.fold(
      (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
      (_) => fetchApplications(),
    );
  }
}

final adoptionRepositoryProvider = Provider<AdoptionRepository>((ref) {
  final client = ref.read(httpClientProvider);
  final baseUrl = ref.read(baseUrlProvider);
  final secureStorage = ref.read(secureStorageProvider);
  return AdoptionRepositoryImpl(client, baseUrl, secureStorage);
});

final adoptionNotifierProvider = StateNotifierProvider<AdoptionNotifier, AsyncValue<List<AdoptionApplication>>>((ref) {
  final adoptionRepository = ref.read(adoptionRepositoryProvider);
  return AdoptionNotifier(adoptionRepository);
});
