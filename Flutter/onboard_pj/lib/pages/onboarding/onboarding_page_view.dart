import 'package:flutter/material.dart';
import 'package:onboard_pj/pages/onboarding/onboarding_child_page.dart';
import 'package:onboard_pj/pages/welcome/welcome_page.dart';
import 'package:onboard_pj/utils/enums/onboarding_page_position.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          // not allow to drag screen to scroll, only custom scroll by button click event.
          physics: const NeverScrollableScrollPhysics(),
          children: [
            OnboardingChildPage(
              key: widget.key,
              onboardingPagePosition: OnboardingPagePosition.page1,
              nextOnPressed: () {
                _pageController.jumpToPage(1);
              },
              backOnPressed: () {},
              skipOnPressed: () {
                completeOnboarding();
                _gotoWelcomePage();
              },
            ),
            OnboardingChildPage(
              key: widget.key,
              onboardingPagePosition: OnboardingPagePosition.page2,
              nextOnPressed: () {
                _pageController.jumpToPage(2);
              },
              backOnPressed: () {
                _pageController.jumpToPage(0);
              },
              skipOnPressed: () {
                completeOnboarding();
                _gotoWelcomePage();
              },
            ),
            OnboardingChildPage(
              key: widget.key,
              onboardingPagePosition: OnboardingPagePosition.page3,
              nextOnPressed: _gotoWelcomePage,
              backOnPressed: () {
                _pageController.jumpToPage(1);
              },
              skipOnPressed: () {
                completeOnboarding();
                _gotoWelcomePage();
              },
            )
          ],
        ),
      ),
    );
  }

  void _gotoWelcomePage() async {
    completeOnboarding();
    if (context.mounted) {
      Navigator.push(context,
          MaterialPageRoute(builder: (builder) => const WelcomePage()));
    }
  }

  Future<void> completeOnboarding() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isOnboardingCompleted", true);
    } catch (e) {
      print(e);
    }
  }
}
