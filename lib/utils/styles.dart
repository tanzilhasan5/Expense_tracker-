import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles{
  static TextStyle title25_w500({Color? color}) => GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w500, color: color);
  static TextStyle title26_600({Color? color}) => GoogleFonts.poppins(fontSize: 26.sp, fontWeight: FontWeight.w600, color: color,);
  static TextStyle title27_600({Color? color}) => GoogleFonts.poppins(fontSize: 27.sp, fontWeight: FontWeight.w600, color: color,);
  static TextStyle title28_600({Color? color}) => GoogleFonts.poppins(fontSize: 28.sp, fontWeight: FontWeight.w600, color: color,);
  static TextStyle title23_500({Color? color}) => GoogleFonts.poppins(fontSize: 23.sp, fontWeight: FontWeight.w500, color: color,);
  static TextStyle title26_500({Color? color}) => GoogleFonts.poppins(fontSize: 26.sp, fontWeight: FontWeight.w500, color: color,);
  static TextStyle title14_w500({Color? color}) => GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w500, color: color,);
  static TextStyle title14_w400({Color? color}) => GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w400, color: color,);
  static TextStyle titlenitor14_w400({Color? color}) => GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w400, color: color,);
  static TextStyle title16_w500({Color? color}) => GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w500, color: color);
  static TextStyle title20_w500({Color? color}) => GoogleFonts.poppins(fontSize: 20.sp, fontWeight: FontWeight.w500, color: color);
  static TextStyle title20_w700({Color? color}) => GoogleFonts.poppins(fontSize: 20.sp, fontWeight: FontWeight.w700, color: color);
  static TextStyle title20_w400({Color? color}) => GoogleFonts.poppins(fontSize: 20.sp, fontWeight: FontWeight.w400, color: color);
  static TextStyle title16_w800({Color? color}) => GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w800, color: color);
  static TextStyle title16_w600({Color? color}) => GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w600, color: color);
  static TextStyle title16_w700({Color? color}) => GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w700, color: color);
  static TextStyle title16_w400({Color? color}) => GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w400, color: color);
  static TextStyle title10_w500({Color? color}) => GoogleFonts.poppins(fontSize: 10.sp, fontWeight: FontWeight.w500, color: color);
  static TextStyle title12_w400({Color? color}) => GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w400, color: color);
  static TextStyle title12_w600({Color? color}) => GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w600, color: color);
  static TextStyle title20_w600({Color? color}) => GoogleFonts.poppins(fontSize: 20.sp, fontWeight: FontWeight.w600, color: color);
  static TextStyle title22_w600({Color? color}) => GoogleFonts.poppins(fontSize: 22.sp, fontWeight: FontWeight.w600, color: color);
  static TextStyle title21_w600({Color? color}) => GoogleFonts.poppins(fontSize: 21.sp, fontWeight: FontWeight.w600, color: color);
  static TextStyle title18_w500({Color? color}) => GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w500, color: color);
  static TextStyle title18_w400({Color? color}) => GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w400, color: color);
  static TextStyle title18_w600({Color? color}) => GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w600, color: color);
  static TextStyle title24_w600({Color? color}) => GoogleFonts.poppins(fontSize: 24.sp, fontWeight: FontWeight.w600, color: color);
  static TextStyle title24_w700({Color? color}) => GoogleFonts.poppins(fontSize: 24.sp, fontWeight: FontWeight.w700, color: color);
  static TextStyle title24_w500({Color? color}) => GoogleFonts.poppins(fontSize: 24.sp, fontWeight: FontWeight.w500, color: color);
  static TextStyle title12_w500({Color? color}) => GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w500, color: color);
  static TextStyle title32_w700({Color? color}) => GoogleFonts.poppins(fontSize: 32.sp, fontWeight: FontWeight.w700, color: color);
  static TextStyle title40_w700({Color? color}) => GoogleFonts.poppins(fontSize: 40.sp, fontWeight: FontWeight.w700, color: color);
  static TextStyle title30_w700({Color? color}) => GoogleFonts.poppins(fontSize: 30.sp, fontWeight: FontWeight.w700, color: color);
  static TextStyle title8_w600({Color? color}) => GoogleFonts.poppins(fontSize: 8.sp, fontWeight: FontWeight.w600, color: color);

}

  extension TextStyleExtension on TextStyle {
    TextStyle withColor(Color color) => copyWith(color: color);
}
