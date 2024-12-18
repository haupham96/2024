import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboard_pj/pages/category/create_edit_category.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: GoogleFonts.roboto().fontFamily,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: CreateEditCategory(),
    );
  }
}
