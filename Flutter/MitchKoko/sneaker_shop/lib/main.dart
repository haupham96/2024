import 'package:flutter/material.dart';
import 'package:sneaker_shop/pages/intro_page.dart';

void main() {
  runApp(const MyWidget());
}
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
