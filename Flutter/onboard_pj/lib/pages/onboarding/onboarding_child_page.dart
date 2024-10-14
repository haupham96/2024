import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnboardingChildPage extends StatelessWidget {
  const OnboardingChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildSkipButton(),
        _buildOnboardingImg(),
        _buildOnboardingPageControl(),
        _buildOnboardingTitleAndContent(),
        _buildOnboardingNextAndPrevButton()
      ],
    );
  }
}

Widget _buildSkipButton() {
  return Container(
    alignment: AlignmentDirectional.centerStart,
    margin: const EdgeInsets.only(top: 14),
    child: TextButton(
        onPressed: () {},
        child: Text(
          'SKIP',
          style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.44)),
        )),
  );
}

Widget _buildOnboardingImg() {
  return Image.asset(
    "assets/images/onboarding_1.png",
    width: 271,
    height: 296,
    fit: BoxFit.contain,
  );
}

Widget _buildOnboardingPageControl() {
  return Container();
}

Widget _buildOnboardingTitleAndContent() {
  return Container();
}

Widget _buildOnboardingNextAndPrevButton() {
  return Container();
}
