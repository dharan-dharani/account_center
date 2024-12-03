import 'dart:convert';
import 'package:account_center/login.dart';
import 'package:account_center/model/chiplist.dart';
import 'package:archive/archive.dart';
import 'package:http/http.dart' as http;
import 'package:account_center/constant.dart';
import 'package:account_center/controller/api/apiconnection.dart';
import 'package:account_center/view/customers/customers.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:shared_preferences/shared_preferences.dart';
=======
>>>>>>> 01de4179c37970be9af977bea5b34a7d63612d51

class Listcontroller {
  final TextEditingController list = TextEditingController();
  final TextEditingController search = TextEditingController();
  List<Chiplist> filteredlabellist = [];

  List<String> selectedlabel = [];
  List<Chiplist> chipslist = [];

  addassignlist(String name) {
    if (!selectedlabel.contains(name)) {
      selectedlabel.add(name);
    }
    print(selectedlabel);
  }

  removeassignlist(String name) {
    if (selectedlabel.contains(name)) {
      selectedlabel.remove(name);
    }
    print(selectedlabel);
  }

  void filterData(String query, Function() refreshParent) {
    if (query.isEmpty) {
      filteredlabellist = chipslist;
    } else {
      filteredlabellist = chipslist
          .where((list) =>
              list.chipname.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    refreshParent();
  }

//API Function

  Api api = Api();
  Future<void> fetchlabellist() async {
    try {
      List<Chiplist> fetcheddetails = await api.labellists();

      chipslist = fetcheddetails;
      filteredlabellist = chipslist;
    } catch (e) {
      print('Error fetching labels: $e');
    }
  }

  customerCompresser({data}) {
    final jsonBytes = utf8.encode((data));
    final compressedBytes = GZipEncoder().encode(jsonBytes);

    final compressedJsonData = base64.encode(compressedBytes!);

    return compressedJsonData;
  }

  Future<void> addlistlabel(String id, BuildContext context) async {
    var token = await logincontroller.getToken();
    print(token);
    try {
      Uri url = Uri.parse('$dev/label/add');
      var data = {
        "labels": id,
      };
      String? body = json.encode(data);

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      // print(response.body);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('send Sucessfull')));
        await listcontroller.fetchlabellist();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Send failed')));
      }
    } catch (e) {
      print("label add error: $e");
    }
  }

  Future<void> assignlistlabel(BuildContext context) async {
    var token = await logincontroller.getToken();

    var id = customerController.listOfCustomer;

    Map<String, dynamic> listoflabels = {'ids': id};
    print(listoflabels);
    var listoflabelsEncode = jsonEncode(listoflabels);

    var encodedlabel = customerCompresser(data: listoflabelsEncode.toString());
    print(encodedlabel);
    try {
      Uri url = Uri.parse('$dev/label/assign');
      // var data = {
      //   "label": chipname,
      //   "customerIds":id,
      // };

      var data = {
        "customerIds": encodedlabel,
        "label": selectedlabel,
      };
      print(selectedlabel);
      String? body = json.encode(data);

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      print(body);

      print(response.statusCode);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('send Sucessfull')));
        customerController.clearcustomer(false);
        await customerController.fetchlist();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Send failed')));
      }
    } catch (e) {
      print("agent_error: $e");
    }
  }

  Future<void> deleteListlabel(String chipname, BuildContext context) async {
    var token = await logincontroller.getToken();
    print(token);
    try {
      Uri url = Uri.parse('$dev/label/delete');
      var data = {
        "labels": chipname,
      };
      String? body = json.encode(data);

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      // print(body);
      // print(response.body);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Delete Sucessfull')));
        await listcontroller.fetchlabellist();
      } else if (response.statusCode == 500) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('error')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Send failed')));
      }
    } catch (e) {
      print("label delete error: $e");
    }
  }
}
