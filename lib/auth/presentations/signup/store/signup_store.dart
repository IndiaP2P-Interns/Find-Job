import 'package:find_job/auth/domain/usecases/auth_usecases.dart';
import 'package:find_job/core/validators.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/response_state.dart';

part 'signup_store.g.dart';

class SignUpStore = _SignUpStore with _$SignUpStore;

abstract class _SignUpStore with Store {
  final AuthUseCases authUseCases;
  _SignUpStore(this.authUseCases);

  @observable
  String name = "";

  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  String confirmPassword = "";

  @observable
  bool obscurePassword = true;

  @observable
  bool obscureConfirmPassword = true;

  @observable
  Response<String> state = Success('');

  @observable
  String? emailError, passwordError, nameError, confirmPasswordError;

  @action
  void setName(String value) {
    name = value;
    //nameError = Validators.validateName(value);
  }

  @action
  void setEmail(String value) {
    email = value;
    //emailError = Validators.validateEmail(value);
  }

  @action
  void setPassword(String value) {
    password = value;
    //passwordError = Validators.validatePassword(value);
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
    confirmPasswordError = value != password ? "Passwords do not match" : null;
  }

  @action
  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
  }

  @action
  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
  }

  @action
  Future<void> createAccount() async {
    emailError = Validators.validateEmail(email);
    passwordError = Validators.validatePassword(password);
    nameError = Validators.validateName(name);

    if (emailError != null ||
        passwordError != null ||
        nameError != null ||
        password != confirmPassword) {
      return;
    }

    state = Loading();
    try {
      late Response<String> result;

      result = await authUseCases.signup(name, email, password);

      // handle result type here
      if (result is Success<String>) {
        state = Success(result.data);
      } else if (result is Error<String>) {
        state = Error(result.message);
      } else {
        state = Error("Unknown error occurred");
      }
    } catch (e) {
      state = Error(e.toString());
    }
  }
}
