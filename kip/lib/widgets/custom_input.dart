import 'package:flutter/material.dart';
import 'package:kip/core/theme/app_colors.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final void Function(String)? onSubmitted;

  const CustomInput({
    super.key,
    this.hintText = "Digite ou fale",
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // cor da sombra
            spreadRadius: 1, // espalhamento
            blurRadius: 5, // suavidade
            offset: Offset(0, 3), // posição da sombra
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          suffixIcon: const Icon(Icons.mic),
          filled: true,
          fillColor: AppColors.white, // mantém a cor de fundo
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
