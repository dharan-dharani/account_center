import 'dart:convert';
import 'package:archive/archive.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:account_center/controller/api/api_connection.dart';
import 'package:account_center/model/customer.dart';
import 'package:account_center/view/customers/customers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';
import '../login.dart';
import '../model/chiplist.dart';

class CustomerController extends GetxController {
  final TextEditingController cname = TextEditingController();
  final TextEditingController cdname = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController code = TextEditingController();
  final TextEditingController cmobileno = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController search = TextEditingController();
  final TextEditingController list = TextEditingController();
  final TextEditingController searchlist = TextEditingController();
  final forms = GlobalKey<FormState>();

  List<customer> filteredData = [];
  var customerdata = <customer>[].obs;
  late Rx<ShowCustomerInfo> showCustomerInfo;
  RxBool isSelectAll = false.obs;

   List<Chiplist> filteredlabellist = [];

  List<String> selectedlabel = [];
  var  chipslist =<Chiplist> [].obs;

  var listOfCustomer = <String>[].obs;

// Date Picker 

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

// filter customer

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

//label assign clear 

  void clearcustomer(bool selected) {
    listOfCustomer.clear();
    for (var singlecheck in customerdata) {
      singlecheck.isclick.value = selected;
    }
  }

  // All select option Function

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

  // select Single Delete option Add

  void addToDeleteList(String id) {
    if (!listOfCustomer.contains(id)) {
      listOfCustomer.add(id);
       print(listOfCustomer);
    }
  }

//select  Single Delete option Delete

  void removeFromDeleteList(String id) {
    listOfCustomer.remove(id);
    print(listOfCustomer);
  }

// selected option delete
 
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

// Add label

addassignlist(String name) {
    if (!selectedlabel.contains(name)) {
      selectedlabel.add(name);
    }
    print(selectedlabel);
  }

// remove label

  removeassignlist(String name) {
    if (selectedlabel.contains(name)) {
      selectedlabel.remove(name);
    }
    print(selectedlabel);
  }

// filter label

  void filterDatalist(String query, Function() refreshParent) {
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

// Fetch Customer List

  Future<void> fetchlist() async {
    try {
      var response = await api.customerlists();
      Map<String, dynamic> jsonData = json.decode(response);
      List<dynamic> dataList = jsonData['data'];
      customerdata.value = dataList.map((json) {
        return customer.fromJson(json);
      }).toList();
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

// Fetch Label List

  Future<void> fetchlabellist() async {
    try {
      var response = await api.labellists();
      Map<String, dynamic> jsonData = json.decode(response);
      List<dynamic> dataList = jsonData['labels'];
      chipslist.value=dataList.map((json) => Chiplist(chipname: json)).toList();
    } catch (e) {
      print('Error fetching labels: $e');
    }
  }
  
// Get Token

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    return token;
  }

// Customer Add

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

// Label Add

Future<void> addlistlabel(String id, BuildContext context) async {
    var token = await userController.getToken();
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
        await customerController.fetchlabellist();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Send failed')));
      }
    } catch (e) {
      print("label add error: $e");
    }
  }

// Customer Update

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

// Label Assign

Future<void> assignlistlabel(BuildContext context) async {
    var token = await userController.getToken();

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
        "encodedString": encodedlabel,
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

// Customer Delete

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
 
// Label Delete

  Future<void> deleteListlabel(String chipname, BuildContext context) async {
    var token = await userController.getToken();
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
        await customerController.fetchlabellist();
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


