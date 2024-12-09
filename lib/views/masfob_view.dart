import 'package:account_center/constant.dart';
import 'package:account_center/views/login_view.dart';
import 'package:account_center/views/register_view.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class Masfob extends StatefulWidget {
  const Masfob({super.key});

  @override
  State<Masfob> createState() => _MasfobState();
}


class _MasfobState extends State<Masfob> {
  int index = 0;


  @override
  Widget build(BuildContext context) {
    List<Widget> users = [ Login(onSwitch: () => setState(() => index = 1)),
      Register(onSwitch: () => setState(() => index = 0)),];
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(100),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('logo.webp'),
                    ),
                    DefaultTextStyle(
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              'Masfob Account Center',
                              speed: const Duration(milliseconds: 100),
                            )
                          ],
                          totalRepeatCount: 1,
                          pause: const Duration(milliseconds: 500),
                        )),
                  ],
                ),
              )),
          Expanded(flex: 3, child: users[index]),
        ],
      ),
    );
  }
}
