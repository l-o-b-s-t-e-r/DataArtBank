import 'package:data_art_bank/actions/transaction_actions.dart';
import 'package:data_art_bank/middlewares/auth_middleware.dart';
import 'package:data_art_bank/middlewares/transactions_middleware.dart';
import 'package:data_art_bank/models/states/app_state.dart';
import 'package:data_art_bank/reducers/app_state_reducer.dart';
import 'package:data_art_bank/repositories/auth_repository.dart';
import 'package:data_art_bank/repositories/transactions_repository.dart';
import 'package:data_art_bank/ui/details/transaction_details_screen.dart';
import 'package:data_art_bank/ui/login/login_screen.dart';
import 'package:data_art_bank/ui/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    StoreProvider(
      store: Store<AppState>(
        AppReducer.create,
        initialState: AppState.init(),
        middleware: [
          ...AuthMiddleware(repository: AuthRepository()).create(),
          ...TransactionsMiddleware(
            repository: TransactionsRepository(),
          ).create(),
        ],
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
          MainScreen.routeName: (context) => MainScreen(
                onInit: () => StoreProvider.of<AppState>(context)
                    .dispatch(LoadTransactionsAction()),
              ),
          LoginScreen.routeName: (context) => const LoginScreen(),
          TransactionDetailsScreen.routeName: (context) {
            final id = ModalRoute.of(context)!.settings.arguments as String;
            return TransactionDetailsScreen(id: id);
          }
        },
      ),
    ),
  );
}
