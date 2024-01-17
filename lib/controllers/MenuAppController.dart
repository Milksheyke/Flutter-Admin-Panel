import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:aliafitness_shared_classes/aliafitness_shared_classes.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class MenuAppEvent {}

class SetCurrentScreenEvent extends MenuAppEvent {
  final Routes screen;

  SetCurrentScreenEvent(this.screen);
}

class ToggleMenuEvent extends MenuAppEvent {}

class FetchItemsEvent extends MenuAppEvent {}

abstract class MenuAppState {}

class MenuInitialState extends MenuAppState {}

class CurrentScreenUpdatedState extends MenuAppState {
  final Routes currentScreen;

  CurrentScreenUpdatedState(this.currentScreen);
}

class ItemsFetchedState extends MenuAppState {
  final List<Item> items;

  ItemsFetchedState(this.items);
}

class DrawerToggledState extends MenuAppState {
  final bool isDrawerOpen;

  DrawerToggledState(this.isDrawerOpen);
}

class MenuAppBloc extends Bloc<MenuAppEvent, MenuAppState> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MenuAppBloc() : super(MenuInitialState()) {
    on<SetCurrentScreenEvent>((event, emit) {
      emit(CurrentScreenUpdatedState(event.screen));
    });

    on<ToggleMenuEvent>((event, emit) {
      bool isDrawerOpen = _scaffoldKey.currentState?.isDrawerOpen ?? false;
      if (!isDrawerOpen) {
        _scaffoldKey.currentState?.openDrawer();
      }
      emit(DrawerToggledState(!isDrawerOpen));
    });

    on<FetchItemsEvent>((event, emit) async {
      try {
        var url = Uri.parse(
            '${dotenv.env['SERVER_URL']}${dotenv.env['ITEMS_ENDPOINT']}');
        final response = await http.get(url, headers: {
          'Authorization': dotenv.env['AUTH_TOKEN']!,
          HttpHeaders.contentTypeHeader: ContentType.json.toString()
        });
        if (response.statusCode == 200) {
          List<dynamic> data = json.decode(response.body);
          List<Item> items = data.map((item) => Item.fromJson(item)).toList();
          emit(ItemsFetchedState(items));
        } else {
          // Handle error
        }
      } catch (e) {
        print(e);
      }
    });
  }

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  // Add other methods as needed
}
