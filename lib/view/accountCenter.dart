import 'package:account_center/constant.dart';
import 'package:account_center/view/agent/agent.dart';
import 'package:account_center/view/apps/apps.dart';
import 'package:account_center/view/billing/billing.dart';
import 'package:account_center/view/customers/customers.dart';
import 'package:account_center/view/files/files.dart';
import 'package:account_center/view/integration/integration.dart';
import 'package:account_center/view/myplan/myplan.dart';
import 'package:account_center/view/paymentsdetails/paymentdetails.dart';
import 'package:account_center/view/plan/plan.dart';
import 'package:flutter/material.dart';

class Accountcenter extends StatefulWidget {
  const Accountcenter({super.key});

  @override
  State<Accountcenter> createState() => _AccountcenterState();
}

class _AccountcenterState extends State<Accountcenter> {
  int selectpage = 0;
  List<Widget> pages = [
    const Myplan(),
    const Plan(),
    const Apps(),
    const Agent(),
    const Files(),
    const Customers(),
    const Integration(),
    const Paymentdetails(),
    const Billing(),
  ];

  Widget listofoptions(
      String option, int pageindex, IconData icons, VoidCallback tap) {
    bool isselect = selectpage == pageindex;
    return StatefulBuilder(builder: (context, setState) {
      return InkWell(
        onTap: tap,
        child: ListTile(
          leading: Icon(
            icons,
            size: 25,
            color: isselect ? primaryColor : Colors.black,
          ),
          title: Text(
            option,
            style: TextStyle(
                color: isselect ? primaryColor : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          trailing: Icon(Icons.chevron_right,
              size: 25, color: isselect ? primaryColor : Colors.black),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 184, 188, 233), white],
            begin: Alignment.centerRight,
            end: Alignment.topRight,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: 15, right: 12, left: 12),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'logo.webp',
                              height: 50,
                              width: 50,
                            ),
                            const Text(
                              'Masfob',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Account Center',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: const CircleAvatar(
                                  maxRadius: 20,
                                  backgroundColor: primaryColor,
                                ),
                                title: const Text('Organization Name'),
                                subtitle: const Text('Masfob'),
                                trailing: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit)),
                              ),
                              const Divider(
                                indent: 10,
                                endIndent: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Masfob@gmailcom',
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             const Login()));
                                        },
                                        child: const Text(
                                          'Logout',
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Account',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            children: [
                              listofoptions('My Plans', 0, Icons.article, () {
                                setState(() {
                                  selectpage = 0;
                                });
                              }),
                              listofoptions('Plan', 1, Icons.widgets, () {
                                setState(() {
                                  selectpage = 1;
                                });
                              }),
                              listofoptions('Apps', 2, Icons.apps, () {
                                setState(() {
                                  selectpage = 2;
                                });
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'General',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          height: 200,
                          width: double.infinity,
                          child: Column(
                            children: [
                              listofoptions('Agents', 3, Icons.badge, () {
                                setState(() {
                                  selectpage = 3;
                                });
                              }),
                              listofoptions('Files', 4, Icons.folder, () {
                                setState(() {
                                  selectpage = 4;
                                });
                              }),
                              listofoptions('Customers', 5, Icons.person, () {
                                setState(() {
                                  selectpage = 5;
                                });
                              }),
                              listofoptions('Integration', 6, Icons.extension,
                                  () {
                                setState(() {
                                  selectpage = 6;
                                });
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Payments',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          height: 100,
                          width: double.infinity,
                          child: Column(
                            children: [
                              listofoptions('Payment Details', 7,
                                  Icons.credit_card_rounded, () {
                                setState(() {
                                  selectpage = 7;
                                });
                              }),
                              listofoptions('Billing', 8, Icons.receipt_long,
                                  () {
                                setState(() {
                                  selectpage = 8;
                                });
                              }),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            Expanded(
              flex: 8,
              child: Container(child: pages[selectpage]),
            ),
          ],
        ),
      ),
    );
  }
}
