import 'dart:developer';

import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/custom_text_form_field.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static String id = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  final GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  kLogo,
                  height: 100,
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Scholar Chat ",
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico'),
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Sign In ",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  hintText: 'Email',
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  hintText: 'Password',
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  buttonText: 'Sign In',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      await signInAndUpdateUI(context);
                    } else {
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(
                        "Register Now",
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
        ),
      ),
    );
  }

  Future<void> signInAndUpdateUI(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });
      await signInUser(context);
      setState(() {
        isLoading = false;
      });
      if (context.mounted) {
        Navigator.pushNamed(context, ChatPage.id);
      }
    } on FirebaseAuthException catch (e) {
      loginErrorClassification(e);
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> signInUser(BuildContext context) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }

  void loginErrorClassification(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        {
          showSnackBar(context,
              message:
                  "No user was found for that email. try to register intead");
        }
      case 'wrong-password':
        {
          showSnackBar(context, message: "Incorrect password");
        }
      case 'invalid-credential':
        {
          showSnackBar(context, message: "Invalid username or password");
        }
      case 'too-many-requests':
        {
          showSnackBar(context,
              message: "You tried too many times, try again later");
        }
      case 'invalid-email':
        {
          showSnackBar(context, message: "Invalid email");
        }
      default:
        {
          log('unknown error from firebase: ${e.toString()}');
          showSnackBar(context, message: "Unknown error occured");
        }
    }
  }
}

// log(e.toString());
//       log(e.code);
//       if (e.code == 'user-not-found') {
//         if (context.mounted) {
//           showSnackBar(
//             context,
//             message: "No user was found for that email. try to register intead",
//           );
//         }
//       } else if (e.code == 'wrong-password') {
//         if (context.mounted) {
//           showSnackBar(
//             context,
//             message: "Wrong password",
//           );
//         } else if (e.code == 'too-many-requests') {
//           log("Error code from outside mounted: ${e.code}");
//           if (context.mounted) {
//             log("Error code from mounted: ${e.code}");
//             showSnackBar(
//               context,
//               message: "You tried too many times, try again later",
//             );
//           }
//         } else if (e.code == 'invalid-credential') {
//           log("Error code from outside mounted: ${e.code}");
//           if (context.mounted) {
//             log("Error code from mounted: ${e.code}");
//             showSnackBar(context, message: "Invalid username or password");
//           }
//         } else if (e.code == 'invalid-email') {
//           log("Error code from outside mounted: ${e.code}");
//           if (context.mounted) {
//             log("Error code from mounted: ${e.code}");
//             showSnackBar(context,
//                 message: "Please enter a valid email address");
//           }
//         } else {
//           log("Unknown error");
//           showSnackBar(
//             context,
//             message: "An unknown error occurred",
//           );
//         }
