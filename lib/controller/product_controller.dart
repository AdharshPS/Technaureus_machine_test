import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:technaureus_project/model/product_model.dart';

class ProductController with ChangeNotifier {
  ProductModel productModel = ProductModel();
  var baseUrl = Uri.parse('http://143.198.61.94/');

// all product details
  productView() async {
    var url = Uri.parse('http://143.198.61.94/api/products/');
    var response = await http.get(url);
    print(response);
    if (response.statusCode == 200) {
      var decodeData = jsonDecode(response.body) as Map<String, dynamic>;
      productModel = ProductModel.fromJson(decodeData);
    } else {
      print("api failed");
    }
    notifyListeners();
  }

  int count = 0;

  addProduct(int itemCount) {
    itemCount++;
    count = itemCount;
    notifyListeners();
  }

  incrementProduct(int itemCount) {
    if (itemCount < 10) {
      itemCount++;
      count = itemCount;
    }
    notifyListeners();
  }

  decrementProduct(int itemCount) {
    if (itemCount >= 1) {
      itemCount--;
      count = itemCount;
    } else {
      itemCount = 0;
      count = itemCount;
    }
    notifyListeners();
  }
}
