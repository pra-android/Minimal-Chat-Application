import 'package:chat_application/authentication/login/login.dart';
import 'package:chat_application/constant/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpFooter extends StatelessWidget {
  const SignUpFooter({super.key});

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
            Text("Already Have an Account?"),
            TextButton(
              onPressed: () {
                Get.off(() => LoginPage());
              },
              child: Text(
                "Login Here",
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        )
      ],
    );
  }
}
