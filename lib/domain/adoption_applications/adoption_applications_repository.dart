import 'package:dartz/dartz.dart';
import 'adoption_applications.dart';
import '../auth/auth_failure.dart';

abstract class AdoptionRepository {
  Future<Either<AuthFailure, List<AdoptionApplication>>> fetchApplications();
  Future<Either<AuthFailure, AdoptionApplication>> fetchApplicationById(String id);
  Future<Either<AuthFailure, List<AdoptionApplication>>> fetchUserApplications();
  Future<Either<AuthFailure, Unit>> createApplication(Map<String, dynamic> applicationJson);
  Future<Either<AuthFailure, Unit>> updateApplication(String id, AdoptionApplication application);
  Future<Either<AuthFailure, Unit>> deleteApplication(String id);
}
