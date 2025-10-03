import 'package:flutter/material.dart';

class ResponsiveValues {
  final bool isDesktop;
  final double horizontalPadding;
  final double verticalPadding;
  final double headlineFontSize;
  final double logoHeight;
  final double spacingAfterLogo;

  ResponsiveValues._({
    required this.isDesktop,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.headlineFontSize,
    required this.logoHeight,
    required this.spacingAfterLogo,
  });

  factory ResponsiveValues.of(BoxConstraints constraints) {
    bool isDesktop = constraints.maxWidth > 799;

    return ResponsiveValues._(
      isDesktop: isDesktop,
      horizontalPadding: isDesktop ? 264.0 : 32.0,
      verticalPadding: isDesktop ? 84.0 : 72.0,
      headlineFontSize: isDesktop ? 28.0 : 24.0,
      logoHeight: isDesktop ? 50.0 : 36.0,
      spacingAfterLogo: isDesktop ? 80.0 : 24.0,
    );
  }
}
