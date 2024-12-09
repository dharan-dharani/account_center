import 'package:get/get.dart';

class Chiplist {
  String chipname;
  RxBool chipselect;
  Chiplist({required this.chipname,  
  bool chipselect = false}):chipselect=chipselect.obs;
}
