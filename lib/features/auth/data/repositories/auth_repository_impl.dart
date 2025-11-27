import 'package:dio/dio.dart' hide Response;
import 'package:find_job/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:find_job/features/auth/domain/repositories/auth_repository.dart';
import 'package:find_job/core/network/api_exceptions.dart';
import 'package:find_job/core/network/network_info.dart';
import 'package:find_job/core/response_state.dart';
import 'package:find_job/core/storage/secure_storage_service.dart';
import 'package:flutter/material.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final NetworkInfo networkInfo;
  final SecureStorageService storage;

  AuthRepositoryImpl(this.remote, this.networkInfo, this.storage);

  @override
  Future<Response<String>> login(String email, String password) async {
    if (!await networkInfo.isConnected) {
      return Error("No internet connection.");
    }
    try {
      final res = await remote.login(email, password);
      final data = res.data;
      final responseData = res.data['data']; // 👈 inner "data" object

      await storage.saveTokens(
        responseData["accessToken"],
        responseData["refreshToken"],
      );

      debugPrint("[AuthRepo] ✅ Login response: $data");

      return Success("Login successful!");
    } on ApiException catch (e) {
      debugPrint("[AuthRepo] ✅ api exception: ${e.message}");
      return Error(e.message);
    } catch (e) {
      debugPrint("[AuthRepo] ✅ Login error: ${e}");
      return Error("Unexpected error: $e");
    }
  }

  @override
  Future<Response<String>> signup(
    String name,
    String email,
    String password,
  ) async {
    if (!await networkInfo.isConnected) {
      return Error("No internet connection.");
    }
    try {
      final res = await remote.signup(name, email, password);
      final responseData = res.data['data']; // 👈 inner "data" object

      await storage.saveTokens(
        responseData["accessToken"],
        responseData["refreshToken"],
      );

      debugPrint("[AuthRepo] ✅ Signup response: $responseData");

      return Success("Signup successful!");
    } on ApiException catch (e) {
      debugPrint("[AuthRepo] ✅ signup api exception: ${e.message}");
      return Error(e.message);
    } catch (e) {
      debugPrint("[AuthRepo] ✅ signup error: ${e}");
      return Error("Unexpected error: $e");
    }
  }

  Future<void> logout() async => await storage.clearTokens();
}
