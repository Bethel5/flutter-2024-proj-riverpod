import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/auth/auth_repository_impl.dart';
import '../../domain/auth/auth_repository.dart';
import '../../domain/auth/user.dart';
import 'auth_notifier.dart';

final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

final baseUrlProvider = Provider<String>((ref) {
  return 'http://localhost:3000'; // Replace with your machine's IP
});

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = ref.read(httpClientProvider);
  final baseUrl = ref.read(baseUrlProvider);
  final secureStorage = ref.read(secureStorageProvider);
  return AuthRepositoryImpl(client, baseUrl, secureStorage);
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthNotifier(authRepository);
});
