
import 'package:find_job/core/response_state.dart';

abstract class AuthRepository {
  Future<Response<String>> login(String email, String password);
  Future<Response<String>> signup(String name, String email, String password);
}
