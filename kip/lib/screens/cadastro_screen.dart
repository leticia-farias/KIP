import 'package:flutter/material.dart';
import 'package:kip/core/layout/base_layout.dart';
import 'package:kip/core/theme/app_text_styles.dart';
import 'package:kip/models/package.dart';
import 'package:kip/screens/confirmar_screen.dart';
import 'package:kip/widgets/confirm_button.dart';

class CadastroScreen extends StatelessWidget {
  final Package package;

  const CadastroScreen({super.key, required this.package});

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
                'Cadastro',
                style: AppTextStyles.h2.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 24),
              
              // --- Formulário ---
              _buildTextField(label: 'Nome completo'),
              const SizedBox(height: 16),
              _buildTextField(label: 'E-mail', keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              _buildTextField(label: 'Telefone', keyboardType: TextInputType.phone),
              // --- Fim do Formulário ---

              const Spacer(), // Empurra o botão para a parte inferior
              
              ConfirmButton(
                text: 'Continuar',
                onPressed: () {
                  // Navega para a tela de confirmação, levando os dados do pacote
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ConfirmarScreen(package: package),
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

  // Widget auxiliar para criar os campos de texto
  Widget _buildTextField({required String label, TextInputType? keyboardType}) {
    return TextFormField(
      keyboardType: keyboardType,
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