import 'package:find_job/core/response_state.dart';
import 'package:find_job/core/validators.dart';
import 'package:find_job/auth/domain/usecases/auth_usecases.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final AuthUseCases authUseCases;

  _AuthStore(this.authUseCases);

  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  bool obscurePassword = true;

  @observable
  String? emailError;

  @observable
  String? passwordError;

  @observable
  Response<String> state = Success('');

  @action
  void setEmail(String value) {
    email = value;
    //emailError = Validators.validateEmail(value);
  }

  @action
  void setPassword(String value) {
    password = value;
    // passwordError = Validators.validatePassword(value);
  }

  @action
  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
  }

  @action
  Future<void> authenticate(AuthAction action) async {
    emailError = Validators.validateEmail(email);
    passwordError = Validators.validatePassword(password);

    if (emailError != null || passwordError != null) return;

    state = Loading();

    try {
      late Response<String> result;

      if (action == AuthAction.login) {
        result = await authUseCases.login(email, password);
      }

      // handle result type here
      if (result is Success<String>) {
        state = Success(result.data);
      } else if (result is Error<String>) {
        state = Error(result.message);
      } else {
        state = Error("Unknown error occurred");
      }
    } catch (e) {
      state = Error("Unexpected error: ${e.toString()}");
    }
  }
}
