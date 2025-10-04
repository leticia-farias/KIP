import 'package:flutter/material.dart';
import 'package:kip/core/layout/base_layout.dart';
import 'package:kip/core/theme/app_colors.dart';
import 'package:kip/core/theme/app_text_styles.dart';
import 'package:kip/screens/chat_screen.dart';
import 'package:kip/screens/login_screen.dart'; // Import da tela de login
import 'package:kip/widgets/custom_input.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Navega para a tela de chat com a mensagem inicial do usuário.
  void _handleSubmitted() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    if (mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ChatScreen(initialMessage: text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BaseLayout(
        builder: (context, values) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Centraliza o conteúdo
                    children: [
                      Text(
                        'Olá, sou seu assistente inteligente. Me conte o que você precisa e quanto pode pagar.',
                        style: AppTextStyles.h2
                            .copyWith(color: AppColors.textLight),
                      ),
                      const SizedBox(height: 32),
                      CustomInput(
                        controller: _controller,
                        isLoading: false,
                        onSend: _handleSubmitted,
                      ),
                    ],
                  ),
                ),
              ),
              // Botão para navegar para a tela de login
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: Text(
                    'Já tem uma conta? Faça login',
                    style: AppTextStyles.h4.copyWith(
                      color: AppColors.textLight,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.textLight,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

