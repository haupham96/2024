import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onboard_pj/pages/onboarding/onboarding_child_page.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: PageView(
          children: [
            OnboardingChildPage(key: widget.key),
            OnboardingChildPage(key: widget.key),
            OnboardingChildPage(key: widget.key)
          ],
        ),
      ),
    );
  }
}
