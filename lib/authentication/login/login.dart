import 'package:chat_application/authentication/login/login_footer.dart';
import 'package:chat_application/authentication/login/login_form.dart';
import 'package:chat_application/authentication/login/login_header.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Header
              LoginHeader(),
              //Login Form
              LoginForm(),
              //Footer
              LoginFooter()
            ],
          ),
        ));
  }
}
