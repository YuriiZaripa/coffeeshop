import 'package:dio/dio.dart';

import 'models/item.dart';

class DrinksRepository{

  Future<List<Item>> getDrinks() async {
    final response = await Dio().get("http://192.168.31.84:8080/api/v1/items");
    // final response = await Dio().get("http://localhost:8080/api/v1/items");

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = response.data as List<dynamic>;
      final List<Item> items = jsonList.map((itemJson) => Item.fromJson(itemJson)).toList();

      return items;
    } else {
      throw Exception('Failed to load drinks');
    }
  }
}