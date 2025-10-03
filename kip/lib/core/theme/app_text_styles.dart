import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Use 'final' em vez de 'const' e chame a função GoogleFonts.poppins()
  static final TextStyle h2 = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textLight,
  );

  static final TextStyle p = GoogleFonts.poppins(
    fontSize: 16,
    color: AppColors.textLight,
  );
}