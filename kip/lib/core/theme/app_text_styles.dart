import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Evita que a classe seja instanciada
  AppTextStyles._();

  // h1: fontSize 24, bold, AppColors.primary (usando gradientEnd como primária)
  static final TextStyle h1 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.gradientEnd,
  );

  // h2: fontSize 18, semiBold, AppColors.textDark
  static final TextStyle h2 = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600, // semiBold
    color: AppColors.textDark,
  );
  
  // normal: fontSize 14, normal, AppColors.textLight
  static final TextStyle normal = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
  );

  // caption: fontSize 12, normal, AppColors.grey (usando lightGrey)
  static final TextStyle caption = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.lightGrey,
  );
  
  // Estilo antigo 'p' pode ser mantido ou substituído pelo 'normal'
  static final TextStyle p = GoogleFonts.poppins(
    fontSize: 16,
    color: AppColors.textLight,
  );
}