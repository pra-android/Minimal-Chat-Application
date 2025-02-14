import 'package:chat_application/authentication/signup/sign_up_form.dart';
import 'package:chat_application/authentication/signup/signup_footer.dart';
import 'package:chat_application/authentication/signup/signup_header.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [SignUpHeader(), SignUpForm(), SignUpFooter()],
        ),
      ),
    );
  }
}
