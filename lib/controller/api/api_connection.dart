import 'dart:convert';
import 'package:account_center/constant.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Api {

// get Token 

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    return token;
  }

// Customer get route

  Future customerlists() async {
    var token = await getToken();
    Uri url = Uri.parse('$dev/customer/list');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    // print(response.body);
    // print(response.statusCode);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      Map<String, dynamic> jsonData = json.decode(response.body);
      print(jsonData['message']);
      throw Exception('Failed to load products');
    }
  }

//label get route

  Future labellists() async {
   var token = await getToken();
    Uri url = Uri.parse('$dev/label/list');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    // print(response.body);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      Map<String, dynamic> jsonData = json.decode(response.body);
      print(jsonData['message']);
      throw Exception('Failed to load products');
    }
  }
}
