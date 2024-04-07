import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:technaureus_project/model/customer_model.dart';

class CustomerController with ChangeNotifier {
  CustomerModel customerModel = CustomerModel();
  var baseUrl = Uri.parse('http://143.198.61.94');
// all customer details
  customerView() async {
    var url = Uri.parse('$baseUrl/api/customers/');
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

  searchCustomer(String searchQuery) async {
    var url = Uri.parse('$baseUrl/api/customers/?search_query=$searchQuery');
    var response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var decodeData = jsonDecode(response.body) as Map<String, dynamic>;
      customerModel = CustomerModel.fromJson(decodeData);
    } else {
      print("api failed");
    }
    notifyListeners();
  }

  Future<void> addCustomers({
    required TextEditingController customerName,
    required TextEditingController mobileNumber,
    required TextEditingController email,
    required TextEditingController street,
    required TextEditingController street2,
    required TextEditingController city,
    required TextEditingController pinCode,
    required String? country,
    required String? state,
  }) async {
    try {
      var url = Uri.parse('http://143.198.61.94/api/customers/');
      var body = {
        "name": customerName.text.trim(),
        "profile_pic": "path/to/the/file/",
        "mobile_number": mobileNumber.text.trim(),
        "email": email.text.toLowerCase().trim(),
        "street": street.text.trim(),
        "street_two": street2.text.trim(),
        "city": city.text.trim(),
        "pincode": pinCode.text.trim(),
        "country": country,
        "state": state
      };
      var response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        await customerView();
        print(response.statusCode);
        print(response.body);
      } else {
        print("api failed");
        print(response.statusCode);
        print(response.body);
      }
      notifyListeners();
    } catch (e) {
      print("exception: $e");
    }
  }

  Future<void> editCustomers({
    required TextEditingController customerName,
    required TextEditingController mobileNumber,
    required TextEditingController email,
    required TextEditingController street,
    required TextEditingController street2,
    required TextEditingController city,
    required TextEditingController pinCode,
    required String? country,
    required String? state,
  }) async {
    try {
      var url = Uri.parse('http://143.198.61.94/api/customers/?id=61');
      var response = await http.put(url, body: {
        "name": customerName.text.trim(),
        "profile_pic": "path/to/the/file/",
        "mobile_number": mobileNumber.text.trim(),
        "email": email.text.toLowerCase().trim(),
        "street": street.text.trim(),
        "street_two": street2.text.trim(),
        "city": city.text.trim(),
        "pincode": pinCode.text.trim(),
        "country": country,
        "state": state
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        await customerView();
      } else {
        print(response.statusCode);
      }
      notifyListeners();
    } catch (e) {
      print("exception: $e");
    }
  }
}
