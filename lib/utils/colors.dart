import 'package:flutter/material.dart';




class AppColor{
  static const Color primary= Color(0xff0C2C55);
  static const Color secondary= Color(0xFF0C2C55);
  static const Color green= Color(0xFF8E24AA);
  static const Color dialog= Color(0xFF394b59);
  static const Color textColor= Color(0xff141515);
  static const Color secondarytextColor= Color(0xff4A5565);
  static const Color deepTeal= Color(0xff296374);
  static const Color coolTeal= Color(0xff629FAD);
  static const Color BrightBlue= Color(0xff155DFC);



}
class ScaffoldColor{
  ScaffoldColor._();

  // Primary Color
  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFF0C1B6E), // Deep indigo blue
      Color(0xFF8E24AA), // Vibrant purple
    ],
  );

}

