import 'package:flutter/material.dart';
import 'package:kip/core/layout/base_layout.dart';
import 'package:kip/core/theme/app_colors.dart';
import 'package:kip/core/theme/app_text_styles.dart';
import 'package:kip/screens/chat_screen.dart'; 
import 'package:kip/widgets/custom_input.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController _controller = TextEditingController();
  // 2. O estado de isLoading e o service não são mais necessários aqui
  // bool _isLoading = false;
  // final AssistantService _service = ...

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 3. Simplificar a função de envio
  Future<void> _handleSubmitted() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    if (mounted) {
      // Apenas navega para a ChatScreen, passando a mensagem
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
      body: BaseLayout(
        builder: (context, values) {
          return Builder(
            builder: (BuildContext innerContext) {
              return Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Olá, sou seu assistente inteligente. Me conte o que você precisa e quanto pode pagar.',
                          style: AppTextStyles.h2.copyWith(color: AppColors.textLight),
                        ),
                        const SizedBox(height: 32),
                        CustomInput(
                          controller: _controller,
                          // O isLoading agora é sempre falso aqui
                          isLoading: false,
                          onSend: _handleSubmitted,
                        ),
                        SizedBox(height: values.logoHeight + values.spacingAfterLogo),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}