import 'package:chat_application/constant/image_constant.dart';
import 'package:chat_application/constant/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0)),
          ),
          height: SizeConstant.deviceHeight / 2,
          child: Image.asset(ImageConstant.signUpLogo),
        ),
        SizedBox(
          height: SizeConstant.deviceHeight / SizeConstant.baseHeight * 10,
        ),
        Text(
          "Create A New Account",
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontSize:
                      SizeConstant.deviceWidth / SizeConstant.baseWidth * 16,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: SizeConstant.deviceHeight / SizeConstant.deviceWidth * 12,
        ),
      ],
    );
  }
}
