import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonTextFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final int? maxlength;
  final Function()? onTap;
  final bool? readOnly;
  final Function(String?)? onChange;
  final Widget? suffixIcon;

  const CommonTextFormField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.maxlength,
    this.readOnly = false,
    this.onTap,
    this.onChange,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxlength,

      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onTap: onTap,
      onChanged: onChange,

      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        counterText: '',
        labelText: hintText,
        labelStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Color(0xfffD9DCEC)),
        ),
        contentPadding: EdgeInsets.all(15),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Color(0xFFFFed6508), // Your border color
            width: 1.5, // Increase this value for a thicker border
          ),
        ),
        filled: true,
        fillColor: Color(0x0DD2232A),
      ),
    );
  }
}
