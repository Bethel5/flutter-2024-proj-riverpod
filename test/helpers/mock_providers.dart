
import 'package:flutter_pet_pal/application/auth/auth_notifier.dart';
import 'package:flutter_pet_pal/domain/auth/auth_failure.dart';
import 'package:flutter_pet_pal/domain/auth/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pet_pal/domain/auth/user.dart';
import 'package:dartz/dartz.dart';

final mockAuthNotifierProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  return MockAuthNotifier();
});

class MockAuthNotifier extends AuthNotifier {
  MockAuthNotifier() : super(MockAuthRepository());

  @override
  Future<void> signIn(String email, String password) async {
    state = AsyncValue.data(User(id: '1', email: email, role: 'user', fullName: ''));
  }

  @override
  Future<void> signUp(String fullName, String email, String password) async {
    state = AsyncValue.data(User(id: '2', email: email, role: 'user', fullName: ''));
  }
}

class MockAuthRepository implements AuthRepository {
  @override
  Future<Either<AuthFailure, User>> signIn(String email, String password) async {
    return right(User(id: '1', email: email, role: 'user', fullName: ''));
  }

  @override
  Future<Either<AuthFailure, Unit>> signUp(String fullName, String email, String password) async {
    return right(unit);
  }
}
