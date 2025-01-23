import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final String validateText;
  final TextInputType? keyboardType;
  final void Function(String)? onSubmit;
  final void Function(String)? onChange;
  const CustomTextField({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    required this.controller,
    required this.validateText,
    this.keyboardType,
    this.onSubmit,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      // cursorColor: Color.fromARGB(255, 103, 53, 252),
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        // fillColor: Color.fromARGB(255, 209, 207, 207),
        hintText: hintText,
        suffixIcon: Icon(suffixIcon),
        prefixIcon: prefixIcon,
        // hintStyle: TextStyle(color: const Color.fromARGB(255, 60, 2, 235)),
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value!.isEmpty) {
          return validateText;
        }
        return null;
      },
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
    );
  }
}
