import 'package:flutter/material.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [_buildIcon(), _buildText()],
        ),
      )),
    );
  }

  Widget _buildIcon() {
    return Image.asset(
      "assets/images/splash_icon.png",
      width: 95,
      height: 80,
      fit: BoxFit.contain,
    );
  }

  Widget _buildText() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: const Text(
        "UpTodo",
        style: TextStyle(
            fontSize: 40, fontWeight: FontWeight.w700, color: Colors.white),
      ),
    );
  }
}
