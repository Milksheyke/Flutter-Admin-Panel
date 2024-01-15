import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/main.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/error_404/error_404_screen.dart';
import 'package:admin/screens/items/items_manager_screen.dart';
import 'package:admin/screens/settings/settings_screen.dart';
import 'package:admin/screens/transactions/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class Routes {
  static const String dashboard = 'dashboard';
  static const String transactions = 'transactions';
  static const String itemsManager = 'itemsManager';
  static const String settings = 'settings';
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Listen for changes in MenuAppController
    var currentScreen = context.watch<MenuAppController>().currentScreen;

    Widget screenToShow;
    switch (currentScreen) {
      case Routes.dashboard:
        screenToShow = DashboardScreen();
        break;
      case Routes.itemsManager:
        screenToShow = ItemsManagerScreen();
        break;
      case Routes.transactions:
        screenToShow = TransactionsScreen();
        break;
      case Routes.settings:
        screenToShow = SettingsScreen();
        break;
      default:
        screenToShow = Error404Screen();
    }

    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(flex: 5, child: screenToShow),
          ],
        ),
      ),
    );
  }
}
