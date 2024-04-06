import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:technaureus_project/model/customer_model.dart';

class CustomerController with ChangeNotifier {
  CustomerModel customerModel = CustomerModel();
  var baseUrl = Uri.parse('http://143.198.61.94/');
// all customer details
  cutomerView() async {
    var url = Uri.parse('http://143.198.61.94/api/customers/');
    var response = await http.get(url);
    print(response);
    if (response.statusCode == 200) {
      var decodeData = jsonDecode(response.body) as Map<String, dynamic>;
      customerModel = CustomerModel.fromJson(decodeData);
    } else {
      print("api failed");
    }
    notifyListeners();
  }
}
