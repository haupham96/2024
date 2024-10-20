import 'package:flutter/material.dart';
import 'package:social_media/features/auth/presentation/pages/login_page.dart';
import 'package:social_media/features/auth/presentation/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoginPage ? LoginPage(togglePage:  togglePage) : RegisterPage(togglePage: togglePage);
  }
}
