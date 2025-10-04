// lib/screens/cadastro_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kip/core/layout/base_layout.dart';
import 'package:kip/core/theme/app_text_styles.dart';
import 'package:kip/models/package.dart';
import 'package:kip/screens/Score_screen.dart';
import 'package:kip/widgets/confirm_button.dart';

class CadastroScreen extends StatefulWidget {
  final Package package;

  const CadastroScreen({super.key, required this.package});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _registerUser() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('https://backend-assistente-a5hj.onrender.com/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'password': _passwordController.text,
          'plan': widget.package.name,
        }),
      );

      if (mounted) {
        if (response.statusCode == 200) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => const ScoreScreen(isNewUser: true),
            ),
            (route) => false,
          );
        } else {
          final body = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(body['error'] ?? 'Erro ao cadastrar.')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Erro de conexão. Tente novamente mais tarde.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

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
              _buildTextField(
                  label: 'Nome completo', controller: _nameController),
              const SizedBox(height: 16),
              _buildTextField(
                  label: 'E-mail',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              _buildTextField(
                  label: 'Telefone',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone),
              const SizedBox(height: 16),
              _buildTextField(
                  label: 'Crie uma senha',
                  controller: _passwordController,
                  obscureText: true),
              const Spacer(),
              ConfirmButton(
                text: 'Finalizar Cadastro',
                isLoading: _isLoading,
                onPressed: _registerUser,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}