import 'package:account_center/constant.dart';
import 'package:account_center/controllers/api/api_controller.dart';
import 'package:account_center/controllers/customer_controller.dart';
import 'package:account_center/models/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  State<Customers> createState() => CustomerState();
}

Api api = Api();
final CustomerController customerController = Get.put(CustomerController());

class CustomerState extends State<Customers> {
  @override
  void initState() {
    super.initState();
    customerController.filteredData.value = customerController.customerdata;
    customerController.fetchlist();
    customerController.fetchlabellist();
  }

  @override
  Widget build(BuildContext context) {
    chips() {
      return Get.dialog(
        AlertDialog(
          title: const Text('Select List'),
          content: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: customerController.chipslist.map((chip) {
                return Obx(
                  () {
                    return FilterChip(
                      label: Text(chip.chipname),
                      selected: chip.chipselect.value,
                      onSelected: (bool value) {
                        chip.chipselect.value = value;
                        if (chip.chipselect.value) {
                          customerController.addassignlist(chip.chipname);
                        } else {
                          customerController.removeassignlist(chip.chipname);
                        }
                      },
                    );
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            Row(
              children: [
                OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size(110, 50),
                        side: const BorderSide(color: primaryColor, width: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text('Cancel',
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14))),
                const SizedBox(width: 10),
                OutlinedButton(
                    onPressed: () {
                      customerController.assignlistlabel();
                    },
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size(110, 50),
                        backgroundColor: primaryColor,
                        side: const BorderSide(color: primaryColor, width: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text('Assign',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14))),
              ],
            )
          ],
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 15.0, bottom: 15, right: 8, left: 8),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Obx(
                    () {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                customerController.listOfCustomer.isEmpty
                                    ? const Icon(Icons.person, size: 30)
                                    : Text(
                                        '${customerController.listOfCustomer.length}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                Text(
                                  customerController.listOfCustomer.isNotEmpty
                                      ? '  Item Selected'
                                      : 'Customers',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 300,
                              height: 40,
                              child: TextFormField(
                                controller: customerController.search,
                                decoration: InputDecoration(
                                  fillColor: white,
                                  filled: true,
                                  hintText: 'Search',
                                  prefixIcon: const Icon(Icons.search),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        customerController.search.clear();

                                        customerController.filterData('');
                                      },
                                      icon: const Icon(Icons.close)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: primaryColor, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: primaryColor, width: 2.0),
                                  ),
                                ),
                                onChanged: (query) {
                                  customerController.filterData(query);
                                  print(query);
                                },
                              ),
                            ),
                            OutlinedButton(
                                onPressed: () {
                                  customerController.deleteSelectedCustomers();
                                },
                                style: OutlinedButton.styleFrom(
                                    minimumSize: const Size(110, 50),
                                    side: const BorderSide(
                                        color: primaryColor, width: 2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Text(
                                    customerController.isSelectAll.value ||
                                            customerController
                                                .listOfCustomer.isNotEmpty
                                        ? 'Delete'
                                        : 'Import',
                                    style: const TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14))),
                            OutlinedButton(
                                onPressed: () {
                                  if (customerController.isSelectAll.value ||
                                      customerController
                                          .listOfCustomer.isNotEmpty) {
                                    chips();
                                  } else {
                                    dialogMethod();
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                    minimumSize: const Size(110, 50),
                                    backgroundColor: primaryColor,
                                    side: const BorderSide(
                                        color: primaryColor, width: 2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Text(
                                    customerController.isSelectAll.value ||
                                            customerController
                                                .listOfCustomer.isNotEmpty
                                        ? 'Assign'
                                        : 'Add',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)))
                          ],
                        ),
                      );
                    },
                  ),
                  Obx(() {
                    if (customerController.customerdata.isEmpty) {
                      return const Text('No Data');
                    }
                    return PaginatedDataTable(
                      columns: [
                        const DataColumn(
                            label: SizedBox(
                                width: 250,
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 16),
                                ))),
                        const DataColumn(
                            label: SizedBox(
                                width: 250,
                                child: Text(
                                  'Email/Number',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 16),
                                ))),
                        DataColumn(
                            label: SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              const Text(
                                'Edits',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
                              Checkbox(
                                  value: customerController.isSelectAll.value,
                                  onChanged: (bool? value) {
                                    customerController.isSelectAll.value =
                                        value!;
                                    customerController.checkaddall(
                                        customerController.isSelectAll.value);
                                  })
                            ],
                          ),
                        )),
                      ],
                      source: ShowCustomerInfo(customerController.filteredData),
                      dataRowMaxHeight: 80,
                      headingRowColor:
                          const WidgetStatePropertyAll(Colors.white),
                      rowsPerPage: 5,
                      columnSpacing: 20,
                      showCheckboxColumn: true,
                    );
                  })
                ],
              ),
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15, right: 8),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "List",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          OutlinedButton(
                              onPressed: () {
                                Get.dialog(AlertDialog(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  title: const Text('Add a New List'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        controller: customerController.list,
                                        decoration: InputDecoration(
                                          fillColor: white,
                                          filled: true,
                                          labelText: 'List Name',
                                          labelStyle:
                                              const TextStyle(color: black),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: primaryColor, width: 2),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: primaryColor,
                                                width: 2.0),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        // crossAxisAlignment: CrossAxisAlignment.baseline,
                                        children: [
                                          OutlinedButton(
                                              onPressed: () {},
                                              style: OutlinedButton.styleFrom(
                                                  minimumSize:
                                                      const Size(110, 50),
                                                  side: const BorderSide(
                                                      color: primaryColor,
                                                      width: 2),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                              child: const Text('Cancel',
                                                  style: TextStyle(
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14))),
                                          const SizedBox(width: 10),
                                          OutlinedButton(
                                              onPressed: () {
                                                customerController.addlistlabel(
                                                    customerController
                                                        .list.text);
                                              },
                                              style: OutlinedButton.styleFrom(
                                                  minimumSize:
                                                      const Size(110, 50),
                                                  backgroundColor: primaryColor,
                                                  side: const BorderSide(
                                                      color: primaryColor,
                                                      width: 2),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                              child: const Text('Add List',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14))),
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                              },
                              style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(80, 40),
                                  side: const BorderSide(
                                      color: primaryColor, width: 2),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text('Add List',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 220,
                      height: 40,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: white,
                          filled: true,
                          hintText: 'Search List',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: IconButton(
                              onPressed: () {}, icon: const Icon(Icons.close)),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: primaryColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: primaryColor, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Obx(
                      () {
                        return ListView.builder(
                            itemCount: customerController.chipslist.length,
                            itemBuilder: (context, index) {
                              print(customerController.chipslist.length);

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ]),
                                  height: 60,
                                  width: 220,
                                  child: ListTile(
                                    leading: const CircleAvatar(
                                      backgroundColor: primaryColor,
                                      maxRadius: 20,
                                    ),
                                    title: Text(customerController
                                        .chipslist[index].chipname),
                                    subtitle: const Text(
                                      '(0) Contacts',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                    trailing: InkWell(
                                      onTap: () {
                                        customerController.deleteListlabel(
                                            customerController
                                                .chipslist[index].chipname);
                                      },
                                      child: const Icon(
                                          Icons.delete_outline_outlined),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    ))
                  ],
                ),
              ),
            )),
      ],
    );
  }

  Future dialogMethod() {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              title: const Text('Add a New Customer'),
              content: Form(
                key: customerController.forms,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: customerController.cname,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Customer Name',
                        labelStyle: const TextStyle(color: black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2.0),
                        ),
                        fillColor: white,
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: customerController.cdname,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Display Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Customer Display Name',
                        labelStyle: const TextStyle(color: black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2.0),
                        ),
                        fillColor: white,
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: customerController.dob,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Date of Birth';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        labelStyle: const TextStyle(color: black),
                        suffixIcon: IconButton(
                            onPressed: () {
                              customerController
                                  .datetimepicker(context)
                                  .then((_) {
                                setState(() {});
                              });
                            },
                            icon: const Icon(Icons.calendar_month_outlined)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2),
                        ),
                        fillColor: white,
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: customerController.cmobileno,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Mobile Number';
                        }
                        if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                          return 'Please enter a valid 10-digit mobile number.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Customer Mobile Number',
                        labelStyle: const TextStyle(color: black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: primaryColor,
                            width: 2,
                          ),
                        ),
                        fillColor: white,
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: customerController.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Email Address';
                        }
                        if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Customer Email',
                        labelStyle: const TextStyle(color: black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2),
                        ),
                        fillColor: white,
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              setState(() {
                                customerController.cname.clear();
                                customerController.cdname.clear();
                                customerController.dob.clear();

                                customerController.cmobileno.clear();
                                customerController.email.clear();
                              });
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                                minimumSize: const Size(110, 50),
                                side: const BorderSide(
                                    color: primaryColor, width: 2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: const Text('Cancel',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14))),
                        const SizedBox(width: 10),
                        OutlinedButton(
                            onPressed: () {
                              if (customerController.forms.currentState!
                                  .validate()) {
                                customerController.addcustomers(
                                  customerController.cname.text,
                                  customerController.cdname.text,
                                  customerController.email.text,
                                  customerController.cmobileno.text,
                                  customerController.dob.text,
                                );

                                customerController.cname.clear();
                                customerController.cdname.clear();
                                customerController.dob.clear();

                                customerController.cmobileno.clear();
                                customerController.email.clear();

                                Navigator.pop(context);
                              }
                            },
                            style: OutlinedButton.styleFrom(
                                minimumSize: const Size(110, 50),
                                backgroundColor: primaryColor,
                                side: const BorderSide(
                                    color: primaryColor, width: 2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: const Text('Add',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14))),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}

class ShowCustomerInfo extends DataTableSource {
  //final BuildContext context;
  // final List<customer> data;
  // ShowCustomerInfo(
  //  {
  //   //required this.context,
  //    this.data,
  // });

  final List<customer> data;

  ShowCustomerInfo(this.data);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final row = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(row.CName.toString()),
            Text(row.CDName.toString()),
            Text(row.DOB.toString()),
          ],
        )),
        DataCell(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(row.Email.toString()),
            Text(row.CMobile.toString()),
            Row(
              children: [
                Text(row.clabel.toString()),
              ],
            ),
          ],
        )),
        DataCell(Row(
          children: [
            IconButton(
                onPressed: () async {
                  await updatedialogMethod(index);
                },
                icon: const Icon(Icons.edit)),
            Obx(
              () {
                return Checkbox(
                  value: row.isclick.value,
                  onChanged: (bool? value) {
                    row.isclick.value = value!;
                    if (row.isclick.value) {
                      customerController.addToDeleteList(row.id);
                    } else {
                      customerController.removeFromDeleteList(row.id);
                    }
                  },
                );
              },
            )
          ],
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  updatedialogMethod(int index) {
    final TextEditingController updatecname = TextEditingController(
        text: customerController.customerdata[index].CName);
    final TextEditingController updatecdname = TextEditingController(
        text: customerController.customerdata[index].CDName);
    final TextEditingController updatedob =
        TextEditingController(text: customerController.customerdata[index].DOB);

    final TextEditingController updatecmo = TextEditingController(
        text: customerController.customerdata[index].CMobile);
    final TextEditingController updateemail = TextEditingController(
        text: customerController.customerdata[index].Email);

    Future<void> datetimepicker(BuildContext context) async {
      final DateTime? select = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime.now());
      if (select != null) {
        {
          updatedob.text = DateFormat('dd/MM/yyyy').format(select);
        }
      }
    }

    return Get.dialog(AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      title: const Text('Update Customer'),
      content: Form(
        key: customerController.forms,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: updatecname,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Your Name';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Customer Name',
                labelStyle: const TextStyle(color: black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: primaryColor,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
                fillColor: white,
                filled: true,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: updatecdname,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Your Display Name';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Customer Display Name',
                labelStyle: const TextStyle(color: black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
                fillColor: white,
                filled: true,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: updatedob,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Your Date of Birth';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                labelStyle: const TextStyle(color: black),
                suffixIcon: IconButton(
                    onPressed: () {
                      //datetimepicker(context);
                    },
                    icon: const Icon(Icons.calendar_month_outlined)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
                fillColor: white,
                filled: true,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: updatecmo,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Your Mobile Number';
                }
                if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                  return 'Please enter a valid 10-digit mobile number.';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Customer Mobile Number',
                labelStyle: const TextStyle(color: black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
                fillColor: white,
                filled: true,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: updateemail,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Your Email Address';
                }
                if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email address.';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Customer Email',
                labelStyle: const TextStyle(color: black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
                fillColor: white,
                filled: true,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                OutlinedButton(
                    onPressed: () {
                      {
                        updatecname.clear();
                        updatecdname.clear();
                        updatedob.clear();

                        updatecmo.clear();
                        updateemail.clear();
                      }
                      // Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size(110, 50),
                        side: const BorderSide(color: primaryColor, width: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text('Clear',
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14))),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                    if (customerController.forms.currentState!.validate()) {
                      customerController.updatecustomer(
                        updatecname.text,
                        updatecdname.text,
                        updateemail.text,
                        updatecmo.text,
                        updatedob.text,
                        customerController.customerdata[index].id,
                      );

                      // Navigator.pop(context);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(110, 50),
                      backgroundColor: primaryColor,
                      side: const BorderSide(color: primaryColor, width: 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text('Update',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
