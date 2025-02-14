import 'package:chat_application/views/home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  var isLoading = false.obs;
  var hide = true.obs;
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String? validateUsername(String name) {
    return name.isEmpty ? "Username cannot be empty" : null;
  }

  void changePasswordStatus() {
    hide.value = !hide.value;
  }

  String? validateEmail(String email) {
    return GetUtils.isEmail(email) ? null : "Please enter valid email";
  }

  String? validatePassword(String password) {
    return password.length < 6
        ? "Password must contain more than 5 characters"
        : null;
  }

  void validateSignUpForm(
      context, String name, String email, String password) async {
    isLoading.value = true;
    if (signUpKey.currentState!.validate()) {
      await Future.delayed(const Duration(seconds: 2));
      signupPage(name, email, password, context);
    } else {
      await Future.delayed(const Duration(seconds: 1));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your details carefully')),
      );
      isLoading.value = false;
    }
  }

  void signupPage(
      String userName, String email, String password, context) async {
    try {
      isLoading.value = true;
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signup Successfully')),
      );
      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid.toString())
          .set({
        'userName': userName,
        'email': email,
        'userId': FirebaseAuth.instance.currentUser!.uid
      });
      Get.offAll(() => HomeView());
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == "network-request-failed") {
        message = e.toString();
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == "email-already-in-use") {
        message = "Email already in use";
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {}
      isLoading.value = false;
    }
  }
}
