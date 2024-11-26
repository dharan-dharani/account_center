import 'package:flutter/material.dart';

class Agent extends StatelessWidget {
  const Agent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15, right: 8, left: 8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.badge,
              size: 70,
            ),
            Text('Agent')
          ],
        ),
      ),
    );
  }
}
