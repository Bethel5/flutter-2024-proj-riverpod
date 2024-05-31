import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000')); // Replace with your machine's IP
  dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true, error: true, requestHeader: true, responseHeader: true));
  return dio;
});
