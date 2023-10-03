import 'package:data_art_bank/middlewares/auth_middleware.dart';
import 'package:data_art_bank/models/app_state.dart';
import 'package:data_art_bank/reducers/app_state_reducer.dart';
import 'package:data_art_bank/repositories/auth_repository.dart';
import 'package:data_art_bank/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  runApp(
    StoreProvider(
      store: Store<AppState>(
        AppReducer.create,
        initialState: AppState.init(),
        middleware: AuthMiddleware(
          repository: AuthRepository(),
        ).create(),
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const LoginScreen(),
          '/login': (context) => LoginScreen(),
        },
      ),
    ),
  );
}
