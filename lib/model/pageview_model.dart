import 'package:chat_application/constant/image_constant.dart';
import 'package:chat_application/constant/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreenConstant {
  static List<PageViewModel> pageViewModel = [
    PageViewModel(
        decoration: const PageDecoration(imageFlex: 2),
        image: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Image.asset(ImageConstant.chat1),
        ),
        titleWidget: Text(
          "Instant Messaging Made Easy",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConstant.onboardingScreentitle),
        ),
        bodyWidget: Text(
          "Enjoy seamless real-time messaging with a simple and intuitive interface. Connect with your friends and family instantly, whether you're chatting one-on-one or in a group.With fast and reliable message delivery, your conversations stay smooth and uninterrupted.",
          style: TextStyle(fontSize: SizeConstant.onboardingScreenBody),
        )),

    //2
    PageViewModel(
        decoration: const PageDecoration(imageFlex: 2),
        image: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Image.asset(ImageConstant.chat2),
        ),
        titleWidget: Text(
          "Secure & Private Conversations",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConstant.onboardingScreentitle),
        ),
        bodyWidget: Text(
          "Your privacy is our priority. All messages are encrypted, ensuring that your personal chats remain confidential and protected from unauthorized access.Whether you're sharing personal thoughts or professional discussions, chat with confidence knowing your data is secure.",
          style: TextStyle(fontSize: SizeConstant.onboardingScreenBody),
        )),

    //3
    PageViewModel(
        decoration: const PageDecoration(imageFlex: 2),
        image: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Image.asset(ImageConstant.chat3),
        ),
        titleWidget: Text(
          "Share More Than Just Words",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConstant.onboardingScreentitle),
        ),
        bodyWidget: Text(
          "Express yourself beyond text by sharing photos, videos, voice messages, and documents. React with emojis, send GIFs, and make your conversations more lively and engaging. Experience richer communication with multimedia support and instant file sharing.",
          style: TextStyle(fontSize: SizeConstant.onboardingScreenBody),
        )),
  ];
}
