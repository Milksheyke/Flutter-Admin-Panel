import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:admin/constants_and_variables.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:aliafitness_shared_classes/aliafitness_shared_classes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Repository {
  static final Repository _instance = Repository._initClient();
  final http.Client httpClient;
  final String backendUrl;
  final String itemsEndpoint;

  Repository._initClient()
      : httpClient = http.Client(),
        backendUrl =
            dotenv.env[EnvConst.SERVER_URL] ?? EnvConst.readFromEnvFailed,
        itemsEndpoint =
            dotenv.env[EnvConst.ITEMS_ENDPOINT] ?? EnvConst.readFromEnvFailed;

  factory Repository() {
    return _instance;
  }

  Future<List<Item>?> getItems() async {
    try {
      var url = Uri.parse('$backendUrl$itemsEndpoint');
      final response = await httpClient.get(url, headers: {
        HttpHeaders.authorizationHeader: dotenv.env[EnvConst.AUTH_TOKEN]!,
        HttpHeaders.contentTypeHeader: ContentType.json.toString()
      });
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Item> items = data.map((item) => Item.fromJson(item)).toList();
        return items;
      } else {
        log(
            'Received error code from server ${response.statusCode}. '
            'body: ${response.body}',
            error: CouldNotFetchItems());
        return null;
      }
    } catch (e) {
      log('Unexpected error occurred when fetching items from server.',
          error: e);
    }
    return null;
  }

  Future<HttpStatus> putItem(Item updatedItem) async {
    throw UnimplementedError();
  }

  Future<HttpStatus> postItem(Item newItem) async {
    throw UnimplementedError();
  }

  Future<HttpStatus> delItem(Item deletedItem) async {
    throw UnimplementedError();
  }
}
