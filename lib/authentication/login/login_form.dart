import 'package:chat_application/constant/size_constant.dart';
import 'package:chat_application/controller/login_controller.dart';
import 'package:chat_application/diagrams/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});
  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            key: loginController.loginFormKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomTextField(
                        textEditingController: loginController.emailController,
                        obscureText: false,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.teal,
                        ),
                        hintText: "Email",
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Obx(
                        () => CustomTextField(
                          textEditingController:
                              loginController.passwordController,
                          obscureText: loginController.hidePassword.value,
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.teal,
                          ),
                          hintText: "Password",
                          suffixIcons: IconButton(
                              onPressed: () {
                                loginController.changePasswordStatus();
                              },
                              icon: Obx(
                                () => Icon(
                                  loginController.hidePassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.teal,
                                ),
                              )),
                        ),
                      )),
                ),
                SizedBox(
                  height:
                      SizeConstant.deviceHeight / SizeConstant.baseHeight * 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        fixedSize: Size(
                            SizeConstant.deviceWidth / 2 + 60,
                            SizeConstant.deviceHeight /
                                SizeConstant.baseHeight *
                                50)),
                    onPressed: () {
                      loginController.login(
                          loginController.emailController.text,
                          loginController.passwordController.text);
                    },
                    child: Obx(
                      () => loginController.isLoading.value
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "LOG IN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                    ))
              ],
            ))
      ],
    );
  }
}
