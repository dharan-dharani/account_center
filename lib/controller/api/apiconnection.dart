import 'dart:convert';
import 'package:account_center/constant.dart';
import 'package:account_center/model/customer.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> dataList = jsonData['data'];
      return dataList
          .map((json) => customer(
                id: json['_id'] ?? '',
                CName: json['name'] ?? '',
                Email: json['email'] ?? '',
                CDName: json['display_name'] ,
                CMobile: json['contact_number'] ?? '',
               // DOB: DateFormat('dd-MM-yyyy')
                   // .format(DateTime.parse(json['dob'])),
              ))
          .toList();
    } else {
      Map<String, dynamic> jsonData = json.decode(response.body);
      print(jsonData['message']);
      throw Exception('Failed to load products');
    }

    //  String rawData = '''
    // {
    //   "data": [
    //     {
    //       "_id": "673c979cdb0187412285389b",
    //       "name": "divya",
    //       "email": "diana@example.com",
    //       "display_name": "divya",
    //       "contact_number": "9876543440",
    //       "dob": "2000-09-10",
    //       "__v": 0
    //     },
    //     {
    //       "_id": "673c97b2db0187412285389d",
    //       "name": "Ethan",
    //       "email": "ethan@example.com",
    //       "display_name": "ethz",
    //       "contact_number": "9267891234",
    //       "dob": "2000-09-10",
    //       "__v": 0
    //     },
    //     {
    //       "_id": "673c97c8db0187412285389f",
    //       "name": "Fiona",
    //       "email": "fiona@example.com",
    //       "display_name": "fifi",
    //       "contact_number": "9278912345",
    //       "dob": "2000-09-10",
    //       "__v": 0
    //     }
    //   ]
    // }
    // ''';

    //   // Decode the JSON string
    //   Map<String, dynamic> jsonData = json.decode(rawData);

    //   // Extract the list of data
    //   List<dynamic> dataList = jsonData['data'];

    //   // Map the data to a list of `customer` objects
    //   return dataList
    //       .map((json) => customer(
    //             id: json['_id'],
    //             CName: json['name'],
    //             Email: json['email'],
    //             CDName: json['display_name'],
    //             CMobile: json['contact_number'],
    //             DOB: DateFormat('yyyy-MM-dd').format(
    //               DateTime.parse(
    //                 json['dob'],
    //               ),
    //             ),
    //           ))
    //       .toList();
  }
}
