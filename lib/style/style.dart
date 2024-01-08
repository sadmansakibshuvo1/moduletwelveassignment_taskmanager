
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PrimaryColor {
  static Color color = const Color(0xFF21bf73);
}

PinTheme customPinTheme() {
  return PinTheme(
    shape: PinCodeFieldShape.box,
    borderRadius: BorderRadius.circular(5),
    fieldHeight: 50,
    fieldWidth: 50,
    inactiveFillColor: Colors.grey,
    inactiveColor: PrimaryColor.color,
    activeFillColor: Colors.grey,
    selectedColor: PrimaryColor.color,
    selectedFillColor: PrimaryColor.color,
  );
}