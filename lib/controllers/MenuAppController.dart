import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:aliafitness_shared_classes/aliafitness_shared_classes.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class MenuAppController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Item> items;
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

  Future<void> fetchItems() async {
    var url =
        Uri.parse('${dotenv.env['SERVER_URL']}${dotenv.env['ITEMS_ENDPOINT']}');
    try {
      final response = await http.get(url, headers: {
        'Authorization': dotenv.env['AUTH_TOKEN']!,
        HttpHeaders.contentTypeHeader: ContentType.json.toString()
      });
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        items = data.map((item) => Item.fromJson(item)).toList();
        notifyListeners();
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
