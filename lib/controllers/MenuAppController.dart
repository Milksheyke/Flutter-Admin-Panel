import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

class MenuAppController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Routes _currentScreen = Routes.dashboard;
  Routes get currentScreen => _currentScreen;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void setCurrentScreen(Routes screen) {
    _currentScreen = screen;
    notifyListeners();
  }

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}
