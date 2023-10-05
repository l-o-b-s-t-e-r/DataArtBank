import 'package:data_art_bank/actions/transaction_actions.dart';
import 'package:data_art_bank/extensions.dart';
import 'package:data_art_bank/models/states/app_state.dart';
import 'package:data_art_bank/models/states/transactions_state.dart';
import 'package:data_art_bank/selectors/transactions_selector.dart';
import 'package:data_art_bank/ui/main/dashboard_page.dart';
import 'package:data_art_bank/ui/main/transactions_page.dart';
import 'package:data_art_bank/ui/widgets/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({required this.onInit, super.key});

  static const routeName = '/main';

  final VoidCallback onInit;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    widget.onInit();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void onInit(Store<AppState> store) {
    store.dispatch(LoadTransactionsAction());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Toolbar(text: 'Wallet'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _TabBar(controller: _tabController),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const <Widget>[
                  TransactionsPage(),
                  DashboardPage(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({required this.controller, super.key});

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: context.colors.primaryContainer,
      ),
      tabs: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: _TransactionsTab(),
        ),
        Text(
          'Dashboard',
          style: context.styles.labelLarge!
              .copyWith(color: context.colors.onPrimaryContainer),
        ),
      ],
    );
  }
}

class _TransactionsTab extends StatelessWidget {
  const _TransactionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TransactionsState>(
        distinct: true,
        converter: (Store<AppState> store) =>
            TransactionsSelector.select(store.state),
        builder: (context, transactionsState) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Transactions',
                style: context.styles.labelLarge!
                    .copyWith(color: context.colors.onPrimaryContainer),
              ),
              const SizedBox(width: 4),
              SizedBox.square(
                dimension: 24,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colors.primaryContainer,
                  ),
                  child: Center(
                    child: Text('${transactionsState.transactions.length}'),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
