import 'package:flutter_pet_pal/application/adoption_applications/adoption_applications_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_pet_pal/domain/adoption_applications/adoption_applications.dart';
import 'package:flutter_pet_pal/domain/adoption_applications/adoption_applications_repository.dart';
import 'package:flutter_pet_pal/domain/auth/auth_failure.dart';

import 'adoption_notifier_test.mocks.dart';

@GenerateMocks([AdoptionRepository])
void main() {
  late MockAdoptionRepository mockAdoptionRepository;
  late ProviderContainer container;

  setUp(() {
    mockAdoptionRepository = MockAdoptionRepository();
    container = ProviderContainer(overrides: [
      adoptionRepositoryProvider.overrideWithValue(mockAdoptionRepository),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  final testApplications = [
    AdoptionApplication(
      id: '1',
      userId: '1',
      fullName: 'John Doe',
      address: '123 Street',
      phoneNumber: '1234567890',
      typeOfPet: 'Dog',
      gender: 'Male',
      ageRange: 'Adult',
      previousPetOwnershipExperience: 'Yes',
      status: 'Pending',
    ),
  ];

  test('fetchUserApplications success', () async {
    when(mockAdoptionRepository.fetchUserApplications())
        .thenAnswer((_) async => right(testApplications));

    final notifier = container.read(adoptionNotifierProvider.notifier);
    await notifier.fetchUserApplications();

    final state = container.read(adoptionNotifierProvider);
    expect(state, AsyncValue.data(testApplications));
  });

  test('fetchUserApplications failure', () async {
    when(mockAdoptionRepository.fetchUserApplications())
        .thenAnswer((_) async => left(AuthFailure('Failed to fetch applications')));

    final notifier = container.read(adoptionNotifierProvider.notifier);
    await notifier.fetchUserApplications();

    final state = container.read(adoptionNotifierProvider);
    expect(state, isA<AsyncError>());
  });

  test('createApplication success', () async {
    final newApplicationJson = {
      'fullName': 'Jane Doe',
      'address': '456 Avenue',
      'phoneNumber': '0987654321',
      'typeOfPet': 'Cat',
      'gender': 'Female',
      'ageRange': 'Adult',
      'previousPetOwnershipExperience': 'No',
      'status': 'Pending',
    };

    final newApplication = AdoptionApplication.fromJson({
      '_id': '2',
      'userId': '2',
      ...newApplicationJson,
    });

    when(mockAdoptionRepository.createApplication(any))
        .thenAnswer((_) async => right(unit));

    when(mockAdoptionRepository.fetchUserApplications())
        .thenAnswer((_) async => right([...testApplications, newApplication]));

    final notifier = container.read(adoptionNotifierProvider.notifier);
    await notifier.createApplication(newApplicationJson);

    final state = container.read(adoptionNotifierProvider);
    expect(state, isA<AsyncData<List<AdoptionApplication>>>());
    expect(state.value!.length, equals(2));
  });

  test('updateApplication success', () async {
    final updatedApplication = AdoptionApplication(
      id: '1',
      userId: '1',
      fullName: 'John Doe',
      address: '123 Street',
      phoneNumber: '1234567890',
      typeOfPet: 'Dog',
      gender: 'Male',
      ageRange: 'Adult',
      previousPetOwnershipExperience: 'Yes',
      status: 'Approved',
    );

    when(mockAdoptionRepository.updateApplication(any, any))
        .thenAnswer((_) async => right(unit));

    when(mockAdoptionRepository.fetchUserApplications())
        .thenAnswer((_) async => right([updatedApplication]));

    final notifier = container.read(adoptionNotifierProvider.notifier);
    await notifier.updateApplication(updatedApplication.id, updatedApplication);

    final state = container.read(adoptionNotifierProvider);
    expect(state, isA<AsyncData<List<AdoptionApplication>>>());
    expect(state.value!.first.status, equals('Approved'));
  });


  test('deleteApplication success', () async {
    when(mockAdoptionRepository.deleteApplication(any))
        .thenAnswer((_) async => right(unit));

    when(mockAdoptionRepository.fetchUserApplications())
        .thenAnswer((_) async => right([]));

    final notifier = container.read(adoptionNotifierProvider.notifier);
    await notifier.deleteApplication(testApplications.first.id);

    final state = container.read(adoptionNotifierProvider);
    expect(state, isA<AsyncData<List<AdoptionApplication>>>());
    expect(state.value, isEmpty);
  });

}
