
import 'package:find_job/features/auth/domain/repositories/auth_repository.dart';
import 'package:find_job/core/response_state.dart';

enum AuthAction { login, signup }

class AuthUseCases {
  final AuthRepository authRepository;

  AuthUseCases(this.authRepository);

  Future<Response<String>> login(String email, String password) {
    return authRepository.login(email, password);
  }

  Future<Response<String>> signup(String name, String email, String password) {
    return authRepository.signup(name, email, password);
  }
}
