
import 'package:dio/dio.dart';
import 'package:find_job/core/network/dio_client.dart';

class AuthRemoteDataSource {
  final DioClient client;

  AuthRemoteDataSource(this.client);

  Future<Response> login(String email, String password) async {
    return await client.post(
      "auth/login",
      data: {"email": email, "password": password},
    );
  }

  Future<Response> signup(String name, String email, String password) async {
    return await client.post(
      "auth/signup",
      data: {"name": name, "email": email, "password": password},
    );
  }
}
