import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Evita que a classe seja instanciada
  AppTextStyles._();

  // h1: fontSize 24, bold, AppColors.primary (usando gradientEnd como primária)
  static final TextStyle h1 = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.gradientEnd,
  );

  // h2: fontSize 18, semiBold, AppColors.textDark
  static final TextStyle h2 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w500, // semiBold
    color: AppColors.textDark,
  );
  
  static final TextStyle normal = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
  );

  static final TextStyle hintText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.hintText,
  );

  // caption: fontSize 12, normal, AppColors.grey (usando lightGrey)
  static final TextStyle caption = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.lightGrey,
  );
}