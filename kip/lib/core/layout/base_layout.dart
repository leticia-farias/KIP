import 'package:flutter/material.dart';
import 'responsive_values.dart';
import '../theme/app_colors.dart';

class BaseLayout extends StatelessWidget {
  final Widget Function(BuildContext context, ResponsiveValues values) builder;

  const BaseLayout({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final values = ResponsiveValues.of(constraints);

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.gradientStart,
                AppColors.gradientEnd,
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: values.horizontalPadding,
              vertical: values.verticalPadding,
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/Logo.png',
                  height: values.logoHeight,
                ),
                Expanded(
                  child: Center(
                    child: builder(context, values),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
