import 'package:basic_app/pages/first_page.dart';
import 'package:basic_app/pages/home.dart';
import 'package:basic_app/pages/second_page.dart';
import 'package:basic_app/pages/setting.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const String HOME = '/home';
const String SETTING = '/setting';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var names = ["Furina", "Venti", "Nahida", "Zhongli"];
    return MaterialApp(
      home: FirstPage(),
      routes: {
        HOME: (context) => HomePage(),
        SETTING: (context) => SettingPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
