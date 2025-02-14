import 'package:chat_application/constant/size_constant.dart';
import 'package:chat_application/controller/signup_controller.dart';
import 'package:chat_application/diagrams/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SignUpForm extends StatelessWidget {
  SignUpForm({super.key});
  SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            key: signupController.signUpKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomTextField(
                        obscureText: false,
                        validator: (val) {
                          return signupController.validateEmail(val!);
                        },
                        textEditingController: signupController.emailController,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.red,
                        ),
                        hintText: "Enter Email",
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomTextField(
                        obscureText: false,
                        validator: (val) {
                          return signupController.validateUsername(val!);
                        },
                        textEditingController: signupController.nameController,
                        prefixIcon: Icon(
                          Icons.person_2_outlined,
                          color: Colors.red,
                        ),
                        hintText: "Enter Name",
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Obx(
                        () => CustomTextField(
                          obscureText: signupController.hide.value,
                          validator: (val) {
                            return signupController.validatePassword(val!);
                          },
                          textEditingController:
                              signupController.passwordController,
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.red,
                          ),
                          hintText: "Enter Password",
                          suffixIcons: IconButton(
                              onPressed: () {
                                signupController.changePasswordStatus();
                              },
                              icon: Obx(
                                () => Icon(
                                  signupController.hide.value
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
                      signupController.validateSignUpForm(
                          context,
                          signupController.nameController.text,
                          signupController.emailController.text,
                          signupController.passwordController.text);
                    },
                    child: Obx(
                      () => signupController.isLoading.value
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "SIGN UP",
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
