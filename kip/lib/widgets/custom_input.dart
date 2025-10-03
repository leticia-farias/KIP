import 'package:flutter/material.dart';
import 'package:kip/core/theme/app_colors.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isLoading;
  final VoidCallback onSend;

  const CustomInput({
    super.key,
    required this.controller,
    this.hintText = "Digite ou fale",
    this.isLoading = false,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(12),
      shadowColor: Colors.black.withOpacity(0.4),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                hintText: hintText,
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: const Icon(Icons.mic),
              ),
              onSubmitted: (_) => onSend(),
              enabled: !isLoading,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: onSend,
                  ),
          ),
        ],
      ),
    );
  }
}