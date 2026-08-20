import 'package:flutter/material.dart';

/// Comprehensive responsive breakpoint system supporting small Android/iOS phones,
/// standard mobile devices, iPad mini, standard iPad, iPad Pro, and Android tablets.
extension ResponsiveContext on BuildContext {
  /// Check if device width corresponds to a small phone (width < 360)
  bool get isSmallPhone => MediaQuery.of(this).size.width < 360;

  /// Check if device width corresponds to a standard phone (width < 600)
  bool get isPhone => MediaQuery.of(this).size.width < 600;

  /// Check if device width corresponds to a tablet or iPad (width >= 600)
  bool get isTablet => MediaQuery.of(this).size.width >= 600;

  /// Check if device width corresponds to a large tablet or iPad Pro (width >= 900)
  bool get isLargeTablet => MediaQuery.of(this).size.width >= 900;

  /// Current screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Current screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Is landscape orientation
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  /// Dynamically select a value based on device size breakpoint
  T responsiveValue<T>({
    required T phone,
    T? smallPhone,
    T? tablet,
    T? largeTablet,
  }) {
    if (isLargeTablet && largeTablet != null) return largeTablet;
    if (isTablet && tablet != null) return tablet;
    if (isSmallPhone && smallPhone != null) return smallPhone;
    return phone;
  }
}

/// A wrapper widget that constrains content to a maximum width on tablets (iPad/Android Tablet)
/// while allowing 100% fluid width on small/medium smartphones (Android & iOS).
class ResponsiveCenter extends StatelessWidget {
  final Widget child;
  final double maxContentWidth;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry alignment;

  const ResponsiveCenter({
    super.key,
    required this.child,
    this.maxContentWidth = 650.0,
    this.padding,
    this.alignment = Alignment.topCenter,
  });

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding ??
        EdgeInsets.symmetric(
          horizontal: context.responsiveValue(
            smallPhone: 12.0,
            phone: 16.0,
            tablet: 24.0,
            largeTablet: 32.0,
          ),
        );

    return Align(
      alignment: alignment,
      child: Container(
        padding: effectivePadding,
        constraints: BoxConstraints(
          maxWidth: maxContentWidth,
        ),
        child: child,
      ),
    );
  }
}

/// A widget builder that supplies device breakpoint flags for inline custom layout logic
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    bool isPhone,
    bool isTablet,
    bool isLargeTablet,
  ) builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      context.isPhone,
      context.isTablet,
      context.isLargeTablet,
    );
  }
}
