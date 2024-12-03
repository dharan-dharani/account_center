import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:account_center/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/accountCenter.dart';

class Logincontroller {
  final loginformkey = GlobalKey<FormState>();
  final TextEditingController email =
      TextEditingController(text: 'dharan123@gmail.com');
  final TextEditingController password = TextEditingController(text: '12345');

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    return token;
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      Uri url = Uri.parse('$dev/user/login');
      var data = {
        "email": email,
        "password": password,
      };

      String? body = json.encode(data);
      // print(body);
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
          },
          body: body);
      // print(response.statusCode);
      // print(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign in  Successfull...')));
        var token = response.headers['token'];
        //print(token);
        if (token != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("token", token);
          var tokenResponse = await getToken();
          //print(tokenResponse);
          if (tokenResponse != null) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Accountcenter()));
          }
        } else {
          print("Token not found in response headers.");
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Sign in failed')));
      }
    } catch (e) {
      print("login_error: $e");
    }
  }
}
