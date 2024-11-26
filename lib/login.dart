import 'package:account_center/constant.dart';
import 'package:account_center/controller/logincontroller.dart';
import 'package:account_center/register.dart';
import 'package:account_center/view/accountCenter.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  FormPage createState() => FormPage();
}

Logincontroller logincontroller = Logincontroller();

class FormPage extends State<Login> {
  @override
  void dispose() {
    logincontroller.email.dispose();
    logincontroller.password.dispose();
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
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            height: 350,
            width: 500,
            child: Form(
                key: logincontroller.loginformkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: logincontroller.email,
                      decoration: InputDecoration(
                          fillColor: primaryLightColor,
                          filled: true,
                          label: const Text(
                            'Email', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),
                          ),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: primaryColor,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                         enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: primaryLightColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color:primaryLightColor,
                                width: 2.0), 
                          ),
                          errorBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: primaryLightColor
                              ), 
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: primaryLightColor,
                                width: 2.0), 
                          ),),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: logincontroller.password,
                      decoration: InputDecoration(
                          fillColor: primaryLightColor,
                          filled: true,
                          label: const Text(
                            'Password',
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),
                          ),
                          
                          prefixIcon: const Icon(
                            Icons.password,
                            color: primaryColor,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: primaryLightColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color:primaryLightColor,
                                width: 2.0), 
                          ),
                          errorBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: primaryLightColor
                              ), 
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: primaryLightColor,
                                width: 2.0), 
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
                           logincontroller.login(logincontroller.email.text,logincontroller.password.text,context);
                         
                        },
                        style: OutlinedButton.styleFrom(
                            minimumSize: const Size(110, 50),
                            backgroundColor: primaryColor,
                            side:
                                const BorderSide(color: primaryColor, width: 2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        child: const Text('Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14))),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have a account?", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),),
                        const SizedBox(width: 5),
                        Hero(
                          tag: 'dash',
                          child: TextButton(
                            child: const Text(
                              'Register',
                              style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Register()),
                              );
                            },
                          ),
                        )
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
