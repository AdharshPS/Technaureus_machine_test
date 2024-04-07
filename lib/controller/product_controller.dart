import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:technaureus_project/model/product_model.dart';

class ProductController with ChangeNotifier {
  ProductModel productModel = ProductModel();
  var baseUrl = Uri.parse('http://143.198.61.94');

// all product details
  productView() async {
    var url = Uri.parse('$baseUrl/api/products/');
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

  searchProduct(String searchQuery) async {
    var url = Uri.parse('$baseUrl/api/products/?search_query=$searchQuery');
    var response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var decodeData = jsonDecode(response.body) as Map<String, dynamic>;
      productModel = ProductModel.fromJson(decodeData);
    } else {
      print("api failed");
    }
    notifyListeners();
  }

  List<int> productIdList = [];
  List<int> quantityList = [];
  List<int> productPriceList = [];
  orderProduct({
    required int productId,
    required int quantity,
    required int productPrice,
  }) async {
    productIdList.add(productId);
    quantityList.add(quantity);
    productPriceList.add(productPrice);
    try {
      var url = Uri.parse('$baseUrl/api/orders/');
      int totalPrice = 0;
      for (var i = 0; i < productIdList.length; i++) {
        int totalQuantity = 0;
        int totalProductPrice = 0;
        for (var i = 0; i < quantityList.length; i++) {
          totalQuantity += quantityList[i];
        }
        for (var i = 0; i < productPriceList.length; i++) {
          totalProductPrice += productIdList[i];
        }
        totalPrice = totalQuantity * totalProductPrice;
      }
      var body = {
        "customer_id": "2",
        "total_price": totalPrice.toString(),
        "products": [
          for (int i = 0; i < productIdList.length; i++)
            {
              {
                "product_id": productIdList[i],
                "quantity": quantityList[i],
                "price": productPriceList[i]
              },
            }
        ],
      };
      var response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        await productView();
        print(response.statusCode);
        print(response.body);
      } else {
        print(response.statusCode);
        print(response.body);
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
