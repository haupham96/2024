import 'package:flutter/material.dart';
import 'package:onboard_pj/utils/enums/onboarding_page_position.dart';

class OnboardingChildPage extends StatelessWidget {
  final OnboardingPagePosition onboardingPagePosition;
  final VoidCallback nextOnPressed;
  final VoidCallback backOnPressed;
  final VoidCallback skipOnPressed;

  const OnboardingChildPage(
      {super.key,
      required this.onboardingPagePosition,
      required this.nextOnPressed,
      required this.backOnPressed,
      required this.skipOnPressed});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildSkipButton(),
          _buildOnboardingImg(),
          _buildOnboardingPageControl(),
          _buildOnboardingTitleAndContent(),
          _buildOnboardingNextAndPrevButton()
        ],
      ),
    );
  }

  Widget _buildSkipButton() {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      margin: const EdgeInsets.only(top: 14),
      child: TextButton(
          onPressed: skipOnPressed,
          child: Text(
            'SKIP',
            style: TextStyle(
                fontSize: 16,
                fontFamily: "Lato",
                color: Colors.white.withOpacity(0.44)),
          )),
    );
  }

  Widget _buildOnboardingImg() {
    return Image.asset(
      onboardingPagePosition.onboardingPageImage(),
      width: 271,
      height: 296,
      fit: BoxFit.contain,
    );
  }

  Widget _buildOnboardingPageControl() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 26,
            height: 4,
            decoration: BoxDecoration(
                color: onboardingPagePosition == OnboardingPagePosition.page1
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(56)),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 26,
            height: 4,
            decoration: BoxDecoration(
                color: onboardingPagePosition == OnboardingPagePosition.page2
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(56)),
          ),
          Container(
            width: 26,
            height: 4,
            decoration: BoxDecoration(
                color: onboardingPagePosition == OnboardingPagePosition.page3
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(56)),
          )
        ],
      ),
    );
  }

  Widget _buildOnboardingTitleAndContent() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            onboardingPagePosition.onboardingPageTitle(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white.withOpacity(0.88),
                fontFamily: "Lato",
                fontSize: 32,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 42),
          Text(onboardingPagePosition.onboardingPageContent(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.88),
                  fontFamily: "Lato",
                  fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildOnboardingNextAndPrevButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24)
          .copyWith(top: 107, bottom: 24),
      child: Row(
        children: [
          TextButton(
              onPressed: () {
                backOnPressed();
              },
              child: Text(
                "BACK",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Lato",
                    color: Colors.white.withOpacity(0.44)),
              )),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                nextOnPressed.call();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8875FF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              child: Text(
                  onboardingPagePosition == OnboardingPagePosition.page3
                      ? "GET STARTED"
                      : "NEXT",
                  style: const TextStyle(
                      fontSize: 16, fontFamily: "Lato", color: Colors.white)))
        ],
      ),
    );
  }
}
