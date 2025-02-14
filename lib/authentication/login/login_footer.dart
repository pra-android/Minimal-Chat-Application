import 'package:chat_application/authentication/signup/signup.dart';
import 'package:chat_application/constant/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeConstant.deviceHeight / SizeConstant.baseHeight * 35,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Not a member?"),
            TextButton(
              onPressed: () {
                Get.off(() => SignUpPage());
              },
              child: Text(
                "Register Now",
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        )
      ],
    );
  }
}
