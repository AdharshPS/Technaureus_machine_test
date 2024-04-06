import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:technaureus_project/model/customer_model.dart';

class CustomerController with ChangeNotifier {
  CustomerModel customerModel = CustomerModel();
  var baseUrl = Uri.parse('http://143.198.61.94');
// all customer details
  cutomerView() async {
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
    var url = Uri.parse('http://143.198.61.94/api/customers/');
    var response = await http.post(url, body: {
      "name": "abhi",
      "profile_pic": "path/to/the/file/",
      "mobile_number": "1234567890",
      "email": "abhi@example.com",
      "street": "abc street",
      "street_two": "xyz street",
      "city": "malappuram",
      "pincode": "652313",
      "country": "india",
      "state": "kerala"

      // "name": customerName.text.trim(),
      // "profile_pic": "path/to/the/file/",
      // "mobile_number": mobileNumber.text.trim(),
      // "email": email.text.toLowerCase().trim(),
      // "street": street.text.trim(),
      // "street_two": street2.text.trim(),
      // "city": city.text.trim(),
      // "pincode": pinCode.text.trim(),
      // "country": country,
      // "state": state
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      await cutomerView();
      print(response.statusCode);
    } else {
      print("api failed");
    }
    notifyListeners();
  }

  // editCustomers() async {
  //   var url = Uri.parse('http://143.198.61.94/api/customers/?id=61');
  //   var response = await http.put(url, body: {
  //     "name": "ram",
  //     "profile_pic": "path/to/the/file/",
  //     "mobile_number": "7865445239",
  //     "email": "ram@example.com",
  //     "street": "def street",
  //     "street_two": "xyz street",
  //     "city": "kollam",
  //     "pincode": "652875",
  //     "country": "india",
  //     "state": "kerala"
  //   });
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     await cutomerView();
  //     print(response.statusCode);
  //   } else {
  //     print("api failed");
  //   }
  //   notifyListeners();
  // }

  Future<void> editCustomers() async {
    try {
      var url = Uri.parse('http://143.198.61.94/api/customers/?id=61');
      var response = await http.put(url, body: {
        "name": "ram",
        "profile_pic": "path/to/the/file/",
        "mobile_number": "7865445239",
        "email": "ram@example.com",
        "street": "def street",
        "street_two": "xyz street",
        "city": "kollam",
        "pincode": "652875",
        "country": "india",
        "state": "kerala"
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        // Successful update
        print("Customer updated successfully");
      } else {
        // Handle other status codes
        print("API failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      // Handle exceptions
      print("Exception occurred: $e");
    }
  }
}
