import 'package:flutter/material.dart';
import 'package:kip/core/layout/base_layout.dart';
import 'package:kip/core/theme/app_colors.dart';
import 'package:kip/screens/chat_screen.dart';
import 'package:kip/widgets/custom_input.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseLayout(builder: (context, values) {
        return Column(
          children: [
            // Esta coluna ocupa todo o espaço disponível
            Expanded(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // centraliza verticalmente
                children: [
                  Text(
                    'Olá, sou seu assistente inteligente. Me conte o que você precisa e quanto pode pagar.',
                    style: TextStyle(
                      fontSize: values.headlineFontSize,
                      color: AppColors.textLight,
                    ),
                  ),

                  const SizedBox(height: 32),

                  CustomInput(
                    onSubmitted: (value) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const ChatScreen()),
                      );
                    },
                  ),

                  // Espaço extra da logo
                  SizedBox(height: values.logoHeight),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
