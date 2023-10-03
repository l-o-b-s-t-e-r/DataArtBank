import 'package:data_art_bank/actions/actions.dart';
import 'package:data_art_bank/extensions.dart';
import 'package:data_art_bank/models/app_state.dart';
import 'package:data_art_bank/models/login_state.dart';
import 'package:data_art_bank/selectors/selectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Auth',
                  style: context.styles.displayLarge!.copyWith(
                    fontWeight: FontWeight.w900,
                    color: context.colors.primary,
                  ),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 56),
                    child: _LoginForm(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({super.key});

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  bool isLoginEnabled = false;
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loginController.addListener(validateFields);
    passwordController.addListener(validateFields);
  }

  void validateFields() {
    final email = loginController.text;
    final password = passwordController.text;

    setState(() {
      isLoginEnabled = email.isNotEmpty && password.isNotEmpty;
    });
  }

  void onLoginPressed() {
    StoreProvider.of<AppState>(context).dispatch(
      LoginAction(
        login: loginController.text,
        password: passwordController.text,
      ),
    );
  }

  Widget loginButtonContent(LoginStatus loginStatus) {
    if (loginStatus.isLoading()) {
      return SizedBox.square(
        dimension: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          backgroundColor: context.colors.onPrimary,
        ),
      );
    } else {
      return const Text('SIGN IN');
    }
  }

  /*void _incrementCounter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (BuildContext _) => const LoginScreen()),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginState>(
      distinct: true,
      converter: (Store<AppState> store) => LoginSelector.select(store.state),
      onWillChange: (prevState, newState) {
        if (newState.status.isSuccess()) {
          print("NAVIGATE");
        } else {
          print("FUCK");
        }
      },
      builder: (context, loginState) {
        final loginStatus = loginState.status;
        final errorCode = loginStatus.isFailed()
            ? (loginStatus as LoginStatusFailed).code
            : null;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginFormField(
              label: 'Login',
              controller: loginController,
              enabled: !loginStatus.isLoading(),
              displayErrorText: false,
              errorCode: errorCode,
            ),
            const SizedBox(height: 8),
            LoginFormField(
              label: 'Password',
              controller: passwordController,
              enabled: !loginStatus.isLoading(),
              displayErrorText: true,
              obscureText: true,
              errorCode: errorCode,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoginEnabled ? onLoginPressed : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.primary,
                foregroundColor: context.colors.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: loginButtonContent(loginStatus),
              ),
            ),
          ],
        );
      },
    );
  }
}

class LoginFormField extends StatelessWidget {
  const LoginFormField({
    required this.label,
    required this.controller,
    required this.enabled,
    required this.displayErrorText,
    this.obscureText = false,
    this.errorCode,
    super.key,
  });

  final String label;
  final bool obscureText, enabled, displayErrorText;
  final int? errorCode;
  final TextEditingController controller;

  String get errorText => displayErrorText ? "Invalid credentials" : "";

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        errorText: errorCode != null ? errorText : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
