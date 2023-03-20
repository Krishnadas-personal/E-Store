import 'dart:convert';
import 'package:e_store/models/products.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
  List<Products> _productsList = [];

  List<Products> get productsList {
    return [..._productsList];
  }

  Future<void> productDetails(products) async {
    final url = 'https://dummyjson.com/products/category/$products';

    try {
      final response = await http.get(Uri.parse(url));
      final productDetails = json.decode(response.body);

      List<Products> productData = [];
      for (var dataJson in productDetails['products']) {
        productData.add(Products.fromJson(dataJson));
      }
      _productsList = productData;

      notifyListeners();
    } catch (err) {
      throw err;
    }
  }


}
