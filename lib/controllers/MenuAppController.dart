import 'dart:developer';
import 'dart:io';

import 'package:admin/constants_and_variables.dart';
import 'package:admin/controllers/repository.dart';
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

abstract class MenuAppState {}

class MenuInitialState extends MenuAppState {}

class CurrentScreenUpdatedState extends MenuAppState {
  final Routes currentScreen;

  CurrentScreenUpdatedState(this.currentScreen);
}


class DrawerToggledState extends MenuAppState {
  final bool isDrawerOpen;

  DrawerToggledState(this.isDrawerOpen);
}

class MenuAppBloc extends Bloc<MenuAppEvent, MenuAppState> {
  final Repository repository = Repository();
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
  }

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
}

class CouldNotFetchItems implements Exception {
  final errorMessage = "Could not fetch items from backend.";

  @override
  String toString() => errorMessage;
}
