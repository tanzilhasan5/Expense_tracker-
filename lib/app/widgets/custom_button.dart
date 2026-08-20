import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/colors.dart';
import '../../utils/styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? icon;
  final double? height;
  final double? width;
  final double? borderRadius;
  final BorderSide? borderSide;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.height,
    this.width,
    this.borderRadius,
    this.borderSide,
    this.textStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? AppColor.green;
    final effectiveTextColor = textColor ?? Colors.white;
    final effectiveTextStyle = textStyle ?? AppTextStyles.title16_w700(color: effectiveTextColor);

    return SizedBox(
      height: height ?? 54.h,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBackgroundColor,
          foregroundColor: effectiveTextColor,
          disabledBackgroundColor: effectiveBackgroundColor.withOpacity(0.5),
          disabledForegroundColor: effectiveTextColor.withOpacity(0.5),
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
            side: borderSide ?? BorderSide.none,
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 8.w),
            ],
            Text(
              text,
              style: effectiveTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
