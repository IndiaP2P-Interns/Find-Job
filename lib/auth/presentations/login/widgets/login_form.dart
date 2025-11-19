import 'package:flutter/material.dart';
import 'package:find_job/auth/data/repositories/auth_repository_impl.dart';
import 'package:find_job/auth/domain/usecases/auth_usecases.dart';
import 'package:find_job/auth/presentations/login/store/auth_store.dart';
import 'package:find_job/auth/presentations/widgets/auth_button.dart';
import 'package:find_job/auth/presentations/widgets/text_field.dart';
import 'package:find_job/core/di/app_module.dart';
import 'package:find_job/core/nav/app_routes.dart';
import 'package:find_job/core/nav/nav_helper.dart';
import 'package:find_job/core/response_state.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final AuthStore store;
  late final ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();

    store = sl<AuthStore>();

    disposer = reaction<Response<dynamic>?>((_) => store.state, (state) {
      if (state is Error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(state.message)));
      } else if (state is Success) {
        // Optionally check if data is not empty if it's a String or List
        final data = state.data;
        if (data is String && data.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Login successfully!")));

          Future.delayed(const Duration(milliseconds: 500), () {
            NavHelper.goTo(context, AppRoutes.main.home);
          });
        }
      }
    });
  }

  @override
  void dispose() {
    disposer(); // dispose reaction properly
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(
          builder: (_) => AuthTextField(
            hint: "Enter your email",
            obscureText: false,
            errorText: store.emailError,
            prefixIcon: Icons.email,
            onChanged: store.setEmail,
          ),
        ),
        const SizedBox(height: 15),
        Observer(
          builder: (_) => AuthTextField(
            hint: "Password",
            prefixIcon: Icons.lock,
            obscureText: store.obscurePassword,
            showSuffix: true,
            onSuffixTap: store.togglePasswordVisibility,
            errorText: store.passwordError,
            onChanged: store.setPassword,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(onPressed: () {}, child: const Text("Forgot Password")),
          ],
        ),
        const SizedBox(height: 15),
        Observer(
          builder: (_) {
            final isLoading = store.state is Loading;
            return AuthButton(
              btnText: "Login",
              isLoading: isLoading,
              onPressed: () {
                print("button is tappend");
                store.authenticate(AuthAction.login);
              },
            );
          },
        ),
      ],
    );
  }
}
