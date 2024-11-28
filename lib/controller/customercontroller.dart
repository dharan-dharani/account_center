import 'dart:convert';
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
  final TextEditingController list = TextEditingController();
  final TextEditingController search = TextEditingController();
  final forms = GlobalKey<FormState>();
  List addlist = [];
  List<customer> filteredData = [];
  List<customer> customerdata = [];
  bool isSelectAll = false;
  bool chipselect = false;
  final List<String> listOfCustomer = [];
  //final List<String> selectedItems = [];

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
    print(listOfCustomer);
  }

  void addToDeleteList(String id) {
    if (!listOfCustomer.contains(id)) {
      listOfCustomer.add(id);
      // selectedItems.add(id);
      print(listOfCustomer);
    }
  }

  void removeFromDeleteList(String id) {
    listOfCustomer.remove(id);
    print(listOfCustomer);
    // selectedItems.remove(id);
  }

  Future<void> datetimepicker(BuildContext context) async {
    final DateTime? select = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (select != null) {
      dob.text = DateFormat('dd-MM-yyyy').format(select);
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
      //selectedItems.clear();
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

//API Function

  Api api = Api();
  Future<void> fetchlist() async {
    try {
      List<customer> fetcheddetails = await api.apiconnection();

      customerdata = fetcheddetails;
      filteredData = customerdata;
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  // Future<void> labellist() async {
  //   try {
  //     List<String> list = await api.labellists();
  //     addlist = list;
  //   } catch (e) {
  //     print('Error fetching products: $e');
  //   }
  // }

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    return token;
  }

  Future<void> addcustomers(String cname, String cdname, String DOB,
      String Cmobile, String email, BuildContext context) async {
    var token = await getToken();
    try {
      Uri url = Uri.parse('$dev/customer/add');
      var data = {
        "name": cname,
        "email": email,
        "display_name": cdname,
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
      print(response.statusCode);
      print(response.body);
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

  Future<void> update(
      String cname, String cdname, String id, BuildContext context) async {
    var token = await getToken();
    try {
      Uri url = Uri.parse('$dev/customer/update');
      var data = {"name": cname, "display_name": cdname, "id": id};
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
      var data = {
        "id": id,
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
