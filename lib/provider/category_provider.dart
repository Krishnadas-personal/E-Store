import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryProvider with ChangeNotifier {
  List _categoryItems = [];

  List get categoryItems {
    return [..._categoryItems];
  }

  Future<void> categoryFetch() async {
    try {
      const url = 'https://dummyjson.com/products/categories';

      final response = await http.get(Uri.parse(url));
      final addCategory = json.decode(response.body);

      print(addCategory.toString());
      _categoryItems = addCategory;
      print(_categoryItems.toString());
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }


}
