import 'package:flutter/material.dart';
import 'package:kip/core/layout/base_layout.dart';
import 'package:kip/core/theme/app_colors.dart';
import 'package:kip/core/theme/app_text_styles.dart';
import 'package:kip/models/package.dart'; // Verifique se o caminho do import está correto
import 'package:kip/screens/proposal_screen.dart';
import 'package:kip/services/assistant_service.dart';
import 'package:kip/widgets/custom_input.dart';

// 1. Convertido para StatefulWidget
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // 2. A lógica e o estado agora vivem aqui
  final TextEditingController _controller = TextEditingController();
  final AssistantService _service = AssistantService(apiUrl: 'https://backend-assistente-a5hj.onrender.com/');
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Função que busca a oferta e decide o que fazer
  Future<void> _handleSubmitted(BuildContext scaffoldContext) async {
    final text = _controller.text.trim();
    if (text.isEmpty || _isLoading) return;

    setState(() => _isLoading = true);

    try {
      final suggestions = await _service.getSuggestions(text);

      if (suggestions.isNotEmpty && mounted) {
        // SUCESSO: Navega para a tela de proposta
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProposalScreen(package: suggestions.first),
          ),
        );
      } else if (mounted) {
        // FALHA: Mostra o aviso (SnackBar)
        ScaffoldMessenger.of(scaffoldContext).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.gradientEnd,
            content: Text('Nenhuma oferta encontrada para sua solicitação.'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(scaffoldContext).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('Erro ao se conectar com o servidor: $e'),
          ),
        );
      }
    } finally {
      if (mounted) {
        // Limpa o input e para o loading
        _controller.clear();
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseLayout(
        builder: (context, values) {
          // 3. O 'Builder' fornece o context correto para a SnackBar
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
                          textAlign: TextAlign.center,
                          style: AppTextStyles.h2.copyWith(color: AppColors.textLight),
                        ),
                        const SizedBox(height: 32),
                        CustomInput(
                          controller: _controller,
                          isLoading: _isLoading,
                          // 4. A função onSend agora chama a lógica com o context correto
                          onSend: () => _handleSubmitted(innerContext),
                        ),
                        // Espaço para alinhar, pode ser ajustado
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