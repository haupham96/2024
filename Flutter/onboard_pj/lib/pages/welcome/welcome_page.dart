import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon:
                const Icon(Icons.arrow_back_ios_new_outlined, size: 18, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: const Color(0xFF121212),
        body: Column(children: [
          _buildTitleAndDesc(),
          const Spacer(),
          _buildButtonLogin(),
          _buildButtonRegister(),
        ]),
      ),
    );
  }

  Widget _buildTitleAndDesc() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 58),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Welcome to UpTodo",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white.withOpacity(0.88),
                fontFamily: "Lato",
                fontSize: 26,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 42),
          Text("Please login to your account or create new account to continue",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.66),
                  fontFamily: "Lato",
                  fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildButtonLogin() {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8875FF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4))),
          child: const Text("LOGIN",
              style: TextStyle(
                  fontSize: 16, fontFamily: "Lato", color: Colors.white))),
    );
  }

  Widget _buildButtonRegister() {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.symmetric(vertical: 28),
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFF8875FF), width: 1),
                  borderRadius: BorderRadius.circular(4))),
          child: const Text("REGISTER",
              style: TextStyle(
                  fontSize: 16, fontFamily: "Lato", color: Colors.white))),
    );
  }
}
