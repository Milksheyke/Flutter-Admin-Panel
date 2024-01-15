import 'package:flutter/material.dart';

class MenuAppController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _currentScreen = 'dashboard';
  String get currentScreen => _currentScreen;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void setCurrentScreen(String screen) {
    _currentScreen = screen;
    notifyListeners();
  }

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}
