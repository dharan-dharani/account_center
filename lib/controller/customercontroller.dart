import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:account_center/controller/api/apiconnection.dart';
import 'package:account_center/model/customer.dart';
import 'package:account_center/view/customers/customers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class CustomerController extends GetxController {
  final TextEditingController cname = TextEditingController();
  final TextEditingController cdname = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController code = TextEditingController();
  final TextEditingController cmobileno = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController search = TextEditingController();
  final forms = GlobalKey<FormState>();

  List<customer> filteredData = [];
  var customerdata = <customer>[].obs;
  late Rx<ShowCustomerInfo> showCustomerInfo;
  RxBool isSelectAll = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();

  //   showCustomerInfo = ShowCustomerInfo(customerdata).obs;
  // }

  var listOfCustomer = <String>[].obs;

  void filterData(String query) {
    if (query.isEmpty) {
      filteredData = customerdata;
    } else {
      filteredData = customerdata
          .where((customer) =>
              customer.CName.toLowerCase().contains(query.toLowerCase()) ||
              customer.Email.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void clearcustomer(bool selected) {
    listOfCustomer.clear();
    for (var singlecheck in customerdata) {
      singlecheck.isclick.value = selected;
    }
  }

  checkaddall(bool selected) {
    listOfCustomer.clear();
    for (var singlecheck in customerdata) {
      singlecheck.isclick.value = selected;
      if (singlecheck.isclick.value) {
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
       print(listOfCustomer);
    }
  }

  void removeFromDeleteList(String id) {
    listOfCustomer.remove(id);
    print(listOfCustomer);
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

  Future<void> deleteSelectedCustomers() async {
    if (listOfCustomer.isEmpty) {
      Get.snackbar(
          'Customer', ' No customers selected for deletion.',
          snackPosition: SnackPosition.BOTTOM, 
         );
      return;
    }
    try {
      await deleteCustomer(listOfCustomer);
      listOfCustomer.clear();
 Get.snackbar(
          'Customer', ' Selected customers deleted successfully!',
          snackPosition: SnackPosition.BOTTOM, 
         );
     
    } catch (e) {
       Get.snackbar(
          'Customer', ' Failed to delete customers.',
          snackPosition: SnackPosition.BOTTOM, 
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
      var response = await api.apiconnection();
      Map<String, dynamic> jsonData = json.decode(response);
      List<dynamic> dataList = jsonData['data'];
      customerdata.value = dataList.map((json) {
        return customer.fromJson(json);
      }).toList();
      // filteredData = customerdata;
      // print('object');
      // for (var customer in customerdata) {
      //   print(customer.clabel);
      // }
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
      String Cmobile, String DOB) async {
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
      // print(body);
      // print(response.body);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        Get.snackbar(
          'Customer', ' Added Successfull',
          snackPosition: SnackPosition.BOTTOM, 
        );

        await customerController.fetchlist();
      } else {
        Get.snackbar(
          'Customer', ' Added Failed',
          snackPosition: SnackPosition.BOTTOM, // Position
        );
      }
    } catch (e) {
      print("Add Customer Error: $e");
    }
  }

  Future<void> updatecustomer(String cname, String cdname, String email,
      String cmo, String dob, String id ) async {
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
      //  print(body);
      // print(response.body);
      // print(response.statusCode);

      if (response.statusCode == 200) {
        Get.snackbar(
          'Customer', ' Updated Successfull',
          snackPosition: SnackPosition.BOTTOM, 
        );
        await customerController.fetchlist();
      } else {
        Get.snackbar(
          'Customer', ' Update Failed',
          snackPosition: SnackPosition.BOTTOM, 
        );
      }
    } catch (e) {
      print("Update Customer Error: $e");
    }
  }

  Future<void> deleteCustomer(List<String> id) async {
    var token = await getToken();
    try {
      Uri url = Uri.parse('$dev/customer/deletes');
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
 print(body);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.snackbar(
          'Customer',
          ' Delete Successfull',
          snackPosition: SnackPosition.BOTTOM,
        );
        await customerController.fetchlist();
      } else if (response.statusCode == 500) {
        Get.snackbar(
          'Customer',
          ' Error',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Customer',
          ' Delete Failed ',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print("Delete Customer Error: $e");
    }
  }
}
