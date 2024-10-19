import 'package:flutter/material.dart';
import 'package:onboard_pj/pages/welcome/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../onboarding/onboarding_page_view.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  Future<void> checkAppState(BuildContext context) async {
    if (!context.mounted) {
      return;
    }
    bool isCompleted = await _isOnboardingCompleted();
    if (isCompleted) {
      // goto welcome page.
      Navigator.push(context,
          MaterialPageRoute(builder: (builder) => const WelcomePage()));
    } else {
      // goto onboarding.
      Navigator.push(context,
          MaterialPageRoute(builder: (builder) => const OnboardingPageView()));
    }
  }

  Future<bool> _isOnboardingCompleted() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      return sharedPreferences.getBool("isOnboardingCompleted") ?? false;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkAppState(context);
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
