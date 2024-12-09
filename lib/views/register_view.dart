import 'package:account_center/constant.dart';
import 'package:account_center/controllers/user_controller.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final VoidCallback onSwitch;
  const Register({super.key, required this.onSwitch});
  @override
  Signup createState() => Signup();
}

UserController userController = UserController();

class Signup extends State<Register> {
  @override
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: const Offset(0, 3))
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              height: 550,
              width: 500,
              child: Form(
                key: userController.registerformkey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: userController.organizationname,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter your Organization Name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor: white,
                          filled: true,
                          label: const Text(
                            'Organization Name',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: button,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: black, width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: black),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: black, width: 2.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: userController.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter your User Name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor: white,
                          filled: true,
                          label: const Text(
                            'User Name',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: button,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: black, width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: black),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: black, width: 2.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: userController.mobileno,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter your Mobile Number";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor: white,
                          filled: true,
                          label: const Text(
                            'Mobile Number',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          prefixIcon:
                              const Icon(Icons.phone, color: button),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: black, width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: black),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: black, width: 2.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter your EmailAddress";
                          }
                          return null;
                        },
                        controller: userController.email,
                        decoration: InputDecoration(
                          fillColor: white,
                          filled: true,
                          label: const Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          prefixIcon:
                              const Icon(Icons.email, color: button),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: black, width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: black),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: black, width: 2.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter your Password";
                          }
                          return null;
                        },
                        controller: userController.password,
                        decoration: InputDecoration(
                          fillColor: white,
                          filled: true,
                          label: const Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          prefixIcon:
                              const Icon(Icons.password, color: button),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: black, width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: black),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: black, width: 2.0),
                          ),
                        ),
                        //obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton(
                          onPressed: () {
                            userController.register(
                                userController.organizationname.text,
                                userController.name.text,
                                userController.email.text,
                                userController.mobileno.text,
                                userController.password.text,
                                context);
                          },
                          style: OutlinedButton.styleFrom(
                              minimumSize: const Size(110, 50),
                              backgroundColor: button,
                              side: const BorderSide(
                                  color: button, width: 2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text('Register',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have a account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 1),
                          Hero(
                            tag: 'dash',
                            child: TextButton(
                                onPressed: widget.onSwitch,
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 7, 66, 9),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
