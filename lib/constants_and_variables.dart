import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

const defaultPadding = 16.0;

String placeholderImage =
    "https://placehold.co/800?text=Item_Image&font=roboto";
String editText = 'Edit';

class EnvConst {
  static const String readFromEnvFailed = 'URL Not Found in ENV';
  //
  static const String SERVER_URL = 'SERVER_URL';
  static const String ITEMS_ENDPOINT = "ITEMS_ENDPOINT";
  static const String AUTH_TOKEN = "AUTH_TOKEN";
  static const String POSTGRESQL_HOST = "POSTGRESQL_HOST";
  static const String DATABASE_PORT = "DATABASE_PORT";
  static const String DATABASE_NAME = "DATABASE_NAME";
  static const String DATABASE_USERNAME = "DATABASE_USERNAME";
  static const String DATABASE_PASSWORD = "DATABASE_PASSWORD";
  static const String JWT_SECRET = "JWT_SECRET";
  static const String CORS = "CORS";
}
