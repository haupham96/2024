import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Center(
              child: Text(
            'Setting.',
            style: TextStyle(fontSize: 32),
          )),
        ),
      ),
    );
  }
}
