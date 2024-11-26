import 'package:account_center/constant.dart';
import 'package:account_center/controller/registercontroller.dart';
import 'package:account_center/login.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  Signup createState() => Signup();
}

Registercontroller registercontroller = Registercontroller();

class Signup extends State<Register> {
  @override
  void dispose() {
    registercontroller.name.dispose();
    registercontroller.email.dispose();
    registercontroller.password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryLightColor,
              primaryColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: const Offset(0, 3))
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            height: 450,
            width: 500,
            child: Form(
              key: registercontroller.registerformkey,
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
                      controller: registercontroller.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter your Name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: primaryLightColor,
                        filled: true,
                        label: const Text(
                          'UserName',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: primaryColor,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: primaryLightColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: primaryLightColor, width: 2.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: primaryLightColor),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: primaryLightColor, width: 2.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: registercontroller.mobileno,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter your Mobile Number";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: primaryLightColor,
                        filled: true,
                        label: const Text(
                          'Mobile Number',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        prefixIcon:
                            const Icon(Icons.phone, color: primaryColor),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: primaryLightColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: primaryLightColor, width: 2.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: primaryLightColor),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: primaryLightColor, width: 2.0),
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
                      controller: registercontroller.email,
                      decoration: InputDecoration(
                        fillColor: primaryLightColor,
                        filled: true,
                        label: const Text(
                          'Email',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        prefixIcon:
                            const Icon(Icons.email, color: primaryColor),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: primaryLightColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: primaryLightColor, width: 2.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: primaryLightColor),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: primaryLightColor, width: 2.0),
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
                      controller: registercontroller.password,
                      decoration: InputDecoration(
                        fillColor: primaryLightColor,
                        filled: true,
                        label: const Text(
                          'Password',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        prefixIcon:
                            const Icon(Icons.password, color: primaryColor),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: primaryLightColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: primaryLightColor, width: 2.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: primaryLightColor),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: primaryLightColor, width: 2.0),
                        ),
                      ),
                      //obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton(
                        onPressed: () {
                          registercontroller.register(
                              registercontroller.name.text,
                              registercontroller.email.text,
                              registercontroller.mobileno.text,
                              registercontroller.password.text,
                              
                              context);
                        },
                        style: OutlinedButton.styleFrom(
                            minimumSize: const Size(110, 50),
                            backgroundColor: primaryColor,
                            side:
                                const BorderSide(color: primaryColor, width: 2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        child: const Text('Register',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14))),
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()),
                                );
                              },
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
    );
  }
}
