import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/custom_text_field.dart';
import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static String id = "RegisterPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: [
            const SizedBox(
              height: 75,
            ),
            Image.asset(
              "assets/images/scholar.png",
              height: 100,
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                "Scholar Chat ",
                style: TextStyle(
                    fontSize: 32, color: Colors.white, fontFamily: 'pacifico'),
              ),
            ),
            const SizedBox(
              height: 75,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Register",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomTextField(
              hintText: 'Email',
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomTextField(
              hintText: 'Password',
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomButton(
              buttonText: 'Sign Up',
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      color: Color(0xffc7ede6),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
