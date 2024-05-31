import 'package:dartz/dartz.dart';
import 'auth_failure.dart';
import 'user.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, User>> signIn(String email, String password);
  Future<Either<AuthFailure, Unit>> signUp(String fullName, String email, String password);
}
