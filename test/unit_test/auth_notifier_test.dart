
// ignore_for_file: unused_import
import 'package:flutter_pet_pal/application/auth/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_pet_pal/domain/auth/auth_failure.dart';
import 'package:flutter_pet_pal/domain/auth/auth_repository.dart';
import 'package:flutter_pet_pal/domain/auth/user.dart';
import 'package:flutter_pet_pal/application/auth/auth_notifier.dart';
import 'auth_notifier_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockAuthRepository;
  late ProviderContainer container;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    container = ProviderContainer(overrides: [
      authRepositoryProvider.overrideWithValue(mockAuthRepository),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  final testUser = User(id: '1', email: 'test@example.com', fullName: 'Test User', role: 'user');

  test('signIn success', () async {
    when(mockAuthRepository.signIn(any, any))
        .thenAnswer((_) async => right(testUser));

    final notifier = container.read(authNotifierProvider.notifier);
    await notifier.signIn('test@example.com', 'password');

    final state = container.read(authNotifierProvider);
    expect(state, AsyncData<User?>(testUser));
  });

  test('signIn failure', () async {
    when(mockAuthRepository.signIn(any, any))
        .thenAnswer((_) async => left(AuthFailure('Failed to sign in')));

    final notifier = container.read(authNotifierProvider.notifier);
    await notifier.signIn('test@example.com', 'password');

    final state = container.read(authNotifierProvider);
    expect(state, isA<AsyncError>());
  });

  test('signUp success', () async {
    when(mockAuthRepository.signUp(any, any, any))
        .thenAnswer((_) async => right(unit));

    final notifier = container.read(authNotifierProvider.notifier);
    await notifier.signUp('Test User', 'test@example.com', 'password');

    final state = container.read(authNotifierProvider);
    expect(state, const AsyncData<User?>(null));
  });

  test('signUp failure', () async {
    when(mockAuthRepository.signUp(any, any, any))
        .thenAnswer((_) async => left(AuthFailure('Failed to sign up')));

    final notifier = container.read(authNotifierProvider.notifier);
    await notifier.signUp('Test User', 'test@example.com', 'password');

    final state = container.read(authNotifierProvider);
    expect(state, isA<AsyncError>());
  });
}
