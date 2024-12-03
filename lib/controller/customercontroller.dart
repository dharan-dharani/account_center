import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:http/http.dart' as http;
import 'package:account_center/constant.dart';
import 'package:account_center/controller/api/apiconnection.dart';
import 'package:account_center/model/customer.dart';
import 'package:account_center/view/customers/customers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerController {
  final TextEditingController cname = TextEditingController();
  final TextEditingController cdname = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController code = TextEditingController();
  final TextEditingController cmobileno = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController search = TextEditingController();
  final forms = GlobalKey<FormState>();
  List<customer> filteredData = [];
  List<customer> customerdata = [];
  bool isSelectAll = false;
  final List<String> listOfCustomer = [];

  void filterData(String query, Function() refreshParent) {
    if (query.isEmpty) {
      filteredData = customerdata;
    } else {
      filteredData = customerdata
          .where((customer) =>
              customer.CName.toLowerCase().contains(query.toLowerCase()) ||
              customer.Email.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    refreshParent();
  }

  void clearcustomer(bool selected) {
    listOfCustomer.clear();
    for (var singlecheck in customerdata) {
      singlecheck.isclick = selected;
    }
  }

  checkaddall(bool selected) {
    listOfCustomer.clear();
    for (var singlecheck in customerdata) {
      singlecheck.isclick = selected;
      if (singlecheck.isclick) {
        listOfCustomer.add(singlecheck.id);
      } else {
        listOfCustomer.remove(singlecheck.id);
      }
    }
    //print(listOfCustomer);
  }

  void addToDeleteList(String id) {
    if (!listOfCustomer.contains(id)) {
      listOfCustomer.add(id);
      // print(listOfCustomer);
    }
  }

  void removeFromDeleteList(String id) {
    listOfCustomer.remove(id);
    //print(listOfCustomer);
  }

  Future<void> datetimepicker(BuildContext context) async {
    final DateTime? select = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (select != null) {
      dob.text = DateFormat('dd/MM/yyyy').format(select);
    }
  }

  Future<void> deleteSelectedCustomers(BuildContext context) async {
    if (listOfCustomer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No customers selected for deletion.')),
      );
      return;
    }
    try {
      await deleteCustomer(listOfCustomer, context);
      listOfCustomer.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Selected customers deleted successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete customers.')),
      );
    }
  }

// Compresser & Decompressor

  customerDecompresser({data}) {
    final decompressedJsonData = base64.decode(data);
    final decompressedBytes = GZipDecoder().decodeBytes(decompressedJsonData);

    final jsonBytes = utf8.decode((decompressedBytes));
    final datas = json.decode(jsonBytes).cast<Map<String, dynamic>>();
    print(datas);
    return datas;
  }

  customerCompresser({data}) {
    final jsonBytes = utf8.encode((data));
    final compressedBytes = GZipEncoder().encode(jsonBytes);

    final compressedJsonData = base64.encode(compressedBytes!);

    return compressedJsonData;
  }

//API Function

  Api api = Api();
  Future<void> fetchlist() async {
    try {
      List<customer> fetcheddetails = await api.apiconnection();

      customerdata = fetcheddetails;
      filteredData = customerdata;
      print('object');
      for (var customer in customerdata) {
        print(customer.clabel);
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    return token;
  }

  Future<void> addcustomers(String cname, String cdname, String email,
      String Cmobile, String DOB, BuildContext context) async {
    var token = await getToken();
    try {
      Uri url = Uri.parse('$dev/customer/add');
      var data = {
        "name": cname,
        "display_name": cdname,
        "email": email,
        "contact_number": Cmobile,
        "dob": DOB,
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
        await customerController.fetchlist();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Send failed')));
      }
    } catch (e) {
      print("agent_error: $e");
    }
  }

  Future<void> update(String cname, String cdname, String email, String cmo,
      String dob, String id, BuildContext context) async {
    var token = await getToken();
    try {
      Uri url = Uri.parse('$dev/customer/update');
      var data = {
        "name": cname,
        "display_name": cdname,
        "email": email,
        "contact_number": cmo,
        "dob": dob,
        "id": id
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
      print(body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Update Sucessfull')));
        await customerController.fetchlist();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Update failed')));
      }
    } catch (e) {
      print("agent_error: $e");
    }
  }

  Future<void> deleteCustomer(List<String> id, BuildContext context) async {
    var token = await getToken();
    try {
      Uri url = Uri.parse('$dev/customer/delete');
      // var data = {
      //   "id": id,
      // };
      Map<String, dynamic> listofids = {"ids": id};
      var listofidsEncode = jsonEncode(listofids);
      var encodedlist = customerCompresser(data: listofidsEncode.toString());
      var data = {"id": encodedlist};
      String? body = json.encode(data);

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
//  print(body);
//  print(response.statusCode);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Delete Sucessfull')));
        await fetchlist();
      } else if (response.statusCode == 500) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('error')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Send failed')));
      }
    } catch (e) {
      print("agent_error: $e");
    }
  }
}
