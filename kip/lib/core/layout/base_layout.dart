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
        final isDesktop = values.isDesktop;

        // Definindo paddings de acordo com as novas regras
        final double horizontalPadding = isDesktop ? constraints.maxWidth * 0.25 : 32.0;
        final double topPadding = isDesktop ? 84.0 : 72.0;
        final double bottomPadding = 32.0;

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.gradientStart,
                AppColors.gradientEnd,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            // Usando EdgeInsets.fromLTRB para paddings não simétricos
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              topPadding,
              horizontalPadding,
              bottomPadding,
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