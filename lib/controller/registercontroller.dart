import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:account_center/constant.dart';

class Registercontroller {
  final registerformkey = GlobalKey<FormState>();
  final TextEditingController organizationname = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController mobileno = TextEditingController();
  Future<void> register(String organizationname,String name, String email,
   String mobileno,
      String password, BuildContext context) async {
    try {
      Uri url = Uri.parse('$dev/user/register');
      var data = {
        "Organization_name": organizationname,
        "name": name,
        "email": email,
        "contact_number": mobileno,
        "password": password,
        
      };

      String? body = json.encode(data);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: body,
      );
      print(body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sign up Sucessfull')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sign up failed')));
      }
    } catch (e) {
      print("agent_error: $e");
    }
  }
}
