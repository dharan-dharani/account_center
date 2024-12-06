import 'package:account_center/constant.dart';
import 'package:account_center/controller/user_controller.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
    final VoidCallback onSwitch;
  const Login({super.key,required this.onSwitch});
  @override
  FormPage createState() => FormPage();
}

UserController userController = UserController();

class FormPage extends State<Login> {
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
                color: white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 350,
              width: 500,
              child: Form(
                  key: userController.loginformkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    const SizedBox(height: 10),
                      DefaultTextStyle(
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                          child: AnimatedTextKit(animatedTexts: [
                            TyperAnimatedText('Welcome Back...!')
                          ])),
                      const SizedBox(height: 20),
                      TextFormField(
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
                          prefixIcon: const Icon(
                            Icons.email,
                            color: primaryColor,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
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
                          prefixIcon: const Icon(
                            Icons.password,
                            color: primaryColor,
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
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton(
                          onPressed: () {
                            userController.login(userController.email.text,
                                userController.password.text, context);
                          },
                          style: OutlinedButton.styleFrom(
                              minimumSize: const Size(110, 50),
                              backgroundColor: primaryColor,
                              side: const BorderSide(
                                  color: primaryColor, width: 2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text('Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14))),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have a account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Hero(
                            tag: 'dash',
                            child: TextButton(
                              onPressed: widget.onSwitch,
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
