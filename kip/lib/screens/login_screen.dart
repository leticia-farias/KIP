import 'package:flutter/material.dart';
import 'package:kip/core/layout/base_layout.dart';
import 'package:kip/core/theme/app_text_styles.dart';
import 'package:kip/screens/Score_screen.dart';
import 'package:kip/widgets/confirm_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BaseLayout(
        builder: (context, values) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Que bom te ver por aqui!',
                style: AppTextStyles.h1.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Acesse sua conta para continuar.',
                style: AppTextStyles.h4,
              ),
              const SizedBox(height: 32),

              // --- Formulário de Login ---
              _buildTextField(label: 'E-mail', keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              _buildTextField(label: 'Senha', obscureText: true),
              // --- Fim do Formulário ---

              const Spacer(),
              
              ConfirmButton(
                text: 'Entrar',
                onPressed: () {
                  // Lógica de login aqui (no futuro, chamaria o backend)
                  // Por enquanto, navega direto para a tela de perfil
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const ScoreScreen(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        hintText: label,
        filled: true,
        fillColor: Colors.white.withOpacity(0.95),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}