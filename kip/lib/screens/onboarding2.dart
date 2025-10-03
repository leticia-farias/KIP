import 'package:flutter/material.dart';
import 'package:kip/core/layout/base_layout.dart';
import 'package:kip/core/theme/app_colors.dart';
import 'package:kip/screens/chat_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseLayout(builder: (context, values) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              children: [
                Text(
                  'Olá, sou seu assistente inteligente. Me conte o que você precisa e quanto pode pagar.',
                  style: TextStyle(
                    fontSize: values.headlineFontSize,
                    color: AppColors.textLight,
                  ),
                ),
                const SizedBox(height: 32),

                // Caixa de Texto
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Digite ou fale',
                    fillColor: AppColors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(Icons.mic),
                  ),
                  onSubmitted: (value) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const ChatScreen()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: values.logoHeight,
            ),
          ],
        );
      }),
    );
  }
}
