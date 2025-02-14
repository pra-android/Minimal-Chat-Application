import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final IconButton? suffixIcons;
  final TextEditingController? textEditingController;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onsuffixIconPressed;
  final bool? obscureText;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.prefixIcon,
      this.textEditingController,
      this.onsuffixIconPressed,
      this.validator,
      this.obscureText,
      this.suffixIcons});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText!,
      controller: textEditingController,
      decoration: InputDecoration(
          suffixIcon: suffixIcons,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 18.0),
          fillColor: Colors.grey.shade200,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.0),
              borderSide: BorderSide(color: Colors.grey.shade200, width: 0.5)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.0),
              borderSide: BorderSide(color: Colors.grey.shade200, width: 0.5)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.0),
              borderSide: BorderSide(color: Colors.grey.shade200, width: 0.5)),
          hintText: hintText,
          prefixIcon: prefixIcon),
    );
  }
}
