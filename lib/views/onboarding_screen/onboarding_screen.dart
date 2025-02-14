import 'package:chat_application/authentication/login/login.dart';
import 'package:chat_application/model/pageview_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: OnBoardingScreenConstant.pageViewModel,
        showSkipButton: true,
        skip: const Text("Skip"),
        onSkip: () {
          Get.offAll(() => LoginPage());
        },
        done: const Text("Done"),
        next: const Text("Next"),
        onDone: () {
          Get.offAll(() => LoginPage());
        },
      ),
    );
  }
}
