import 'dart:developer';
import 'package:chat_application/constant/size_constant.dart';
import 'package:chat_application/views/home_view.dart';
import 'package:chat_application/views/onboarding_screen/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var hidePassword = true.obs;
  void changePasswordStatus() {
    hidePassword.value = !hidePassword.value;
  }

  void login(String email, String password) async {
    isLoading.value = true;
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      isLoading.value = false;
      Fluttertoast.showToast(
          msg: "Login Successfull",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: SizeConstant.deviceWidth / SizeConstant.baseWidth * 16);
      emailController.clear();
      passwordController.clear();
      Get.offAll(() => HomeView());
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found with this email. Please register first.';
      } else if (e.code == 'invalid-credential') {
        message = 'Incorrect email or password';
      } else if (e.code == 'network-request-failed') {
        message = 'No internet connection. Please check your network.';
      } else {
        message = 'Incorrect email or password';
      }

      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      emailController.clear();
      passwordController.clear();
    } catch (e) {
      isLoading.value = false;
      Fluttertoast.showToast(
          msg: "Something went wrong.Please try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //logout
  Future<void> logOut(context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text("Are you sure?Do you want to logout?"),
            actions: [
              TextButton(
                  onPressed: () {
                    logout();
                  },
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("No"))
            ],
          );
        });
  }

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
      Get.offAll(() => const OnBoardingScreen());
    } catch (e) {
      log("Logout failed: $e");
    }
  }

  //check login status
  Future<void> checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 0));
    if (firebaseAuth.currentUser == null) {
      Get.off(() => const OnBoardingScreen());
    } else {
      Get.off(() => HomeView());
    }
  }
}
