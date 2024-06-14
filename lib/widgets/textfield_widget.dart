import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:urgentrishtapp/constants/color_constant.dart';
import 'package:urgentrishtapp/utils/call_backs_func.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? textInputFormatter;
  final bool isVisibleText;
  final Color? fillColor;
  final double? width;
  final double? height;
  final int maxLines;
  final TextInputType? keyboardType;
  final OnChangedValidator? validator;
  final bool readOnly;
  final bool obscureText;
  final InputBorder? border; // New parameter for border

  const TextFieldWidget({
    super.key,
    this.controller,
    this.height,
    this.textInputFormatter,
    this.prefixIcon,
    required this.hintText,
    this.fillColor,
    this.isVisibleText = false,
    this.readOnly = false,
    this.suffixIcon,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
    this.width,
    this.onChanged,
    required this.obscureText,
    this.border, // Initialize the border parameter
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: fillColor ?? ColorConstants.pink,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextFormField(
          inputFormatters: textInputFormatter,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          onChanged: onChanged,
          readOnly: readOnly,
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          obscureText: obscureText,
          obscuringCharacter: '●',
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w300),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            enabledBorder: border ?? InputBorder.none,
            focusedBorder: border ?? InputBorder.none,
            border: border ?? InputBorder.none,
          ),
        ),
      ),
    );
  }
}

bool isValidEmail(String input) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  return emailRegex.hasMatch(input);
}

bool isValidNumber(String phoneNumber) {
  final RegExp regex = RegExp(r'^\+?[0-9]+$');
  return regex.hasMatch(phoneNumber);
}

bool isValidPakistaniNumber(String phoneNumber) {
  final RegExp regex = RegExp(r'^(\+92|0)?3[0-9]{9}$');

  return regex.hasMatch(phoneNumber);
}

bool isValidCNIC(String cnic) {
  final RegExp regex = RegExp(r'^[0-9]{13}$');

  if (!regex.hasMatch(cnic)) {
    return false;
  }

  const validStartingDigits = ['1', '2', '3', '4', '5', '6', '7', '8'];

  if (!validStartingDigits.contains(cnic[0])) {
    return false;
  }

  return true;
}

bool isValidCRNumber(String input) {
  final RegExp regex = RegExp(r'^\+?[0-9]+$');
  return regex.hasMatch(input);
}

bool isValidName(String name) {
  final RegExp regex = RegExp(r'^[a-zA-Z ]+$');
  final bool hasValidLength = name.length >= 2 && name.length <= 50;
  return regex.hasMatch(name) && hasValidLength;
}

bool isValidAddress(String address) {
  final RegExp regex = RegExp(
    r'^[a-zA-Z0-9@#/*&.,()"\s-]+$',
  );
  final bool hasValidLength = address.length <= 250;
  return regex.hasMatch(address) && hasValidLength;
}

bool isValidCreditCard(String creditCardNumber) {
  final RegExp regex = RegExp(r'^[0-9]{16}$');
  return regex.hasMatch(creditCardNumber);
}

bool isValidZipCode(String zipCode) {
  final RegExp regex = RegExp(r'^[0-9]{4}$');
  return regex.hasMatch(zipCode);
}
