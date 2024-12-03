import 'dart:convert';
import 'package:account_center/constant.dart';
import 'package:account_center/model/chiplist.dart';
import 'package:account_center/model/customer.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    return token;
  }

  Future<List<customer>> apiconnection() async {
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
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> dataList = jsonData['data'];
      return dataList
          .map((json) => customer(
                id: json['_id'] ?? '',
                CName: json['name'] ?? '',
                Email: json['email'] ?? '',
                CDName: json['display_name'],
                CMobile: json['contact_number'] ?? '',
                clabel: json['labels'] ?? '',
                DOB: json['dob'] ?? '',
              ))
          .toList();
    } else {
      Map<String, dynamic> jsonData = json.decode(response.body);
      print(jsonData['message']);
      throw Exception('Failed to load products');
    }
  }

  Future<List<Chiplist>> labellists() async {
   // print('called');
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
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> dataList = jsonData['labels'];
      print(dataList);
      return dataList.map((json) => Chiplist(chipname: json)).toList();
    } else {
      Map<String, dynamic> jsonData = json.decode(response.body);
      print(jsonData['message']);
      throw Exception('Failed to load products');
    }
  }
}
