import 'package:chat_app/Blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/Cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/custom_text_form_field.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  static String id = "LoginPage";

  final GlobalKey<FormState> formKey = GlobalKey();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          BlocProvider.of<AuthBloc>(context).isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatPage.id);
          BlocProvider.of<AuthBloc>(context).isLoading = false;
        } else if (state is LoginFailure) {
          showSnackBar(context, message: state.message);
          BlocProvider.of<AuthBloc>(context).isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: BlocProvider.of<AuthBloc>(context).isLoading,
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
                      BlocProvider.of<AuthBloc>(context).email = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hintText: 'Password',
                    obsecureText: true,
                    onChanged: (value) {
                      BlocProvider.of<AuthBloc>(context).password = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    buttonText: 'Sign In',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(LoginEvent());
                      } else {}
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
      ),
    );
  }
}
