import 'package:get/get.dart';

class SizeConstant {
  static var deviceWidth = Get.context!.width;
  static var deviceHeight = Get.context!.height;
  static double baseWidth = 375.0; // Reference screen width
  static double baseHeight = 812.0; //Reference screen height
  static var onboardingScreentitle = deviceWidth / baseWidth * 19;
  static var onboardingScreenBody = deviceWidth / baseWidth * 13;
}
