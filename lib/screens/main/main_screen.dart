import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/side_menu.dart';

enum Routes {
  dashboard,
  transactions,
  itemsManager,
  settings;

  @override
  String toString() => this.name;

  String get title {
    switch (this) {
      case Routes.dashboard:
        return "Dashboard";
      case Routes.transactions:
        return "Transactions";
      case Routes.itemsManager:
        return "Items Manager";
      case Routes.settings:
        return "Settings";
      default:
        return "Oops. Don't know what the title should be";
    }
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MenuAppBloc>(context)
        .add(SetCurrentScreenEvent(Routes.dashboard));
    return BlocBuilder<MenuAppBloc, MenuAppState>(
      builder: (context, state) {
        return Scaffold(
          key: BlocProvider.of<MenuAppBloc>(context).scaffoldKey,
          drawer: SideMenu(),
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Responsive.isDesktop(context))
                  Expanded(
                    child: SideMenu(),
                  ),
                Expanded(flex: 5, child: DashboardScreen()),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
