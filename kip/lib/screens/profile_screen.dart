import 'package:flutter/material.dart';
import 'package:kip/core/layout/base_layout.dart';
import 'package:kip/core/theme/app_colors.dart';
import 'package:kip/core/theme/app_text_styles.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseLayout(
        builder: (context, values) {
          final isDesktop = values.isDesktop;

          final profileCard = _buildProfileCard();
          final scoreCard = _buildScoreCard();
          final newChatButton = _buildNewChatButton();

          if (isDesktop) {
            // Layout Desktop: Colunas lado a lado
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1080),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [profileCard, const SizedBox(height: 24), newChatButton],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 1,
                      child: scoreCard,
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Layout Mobile: Itens empilhados com rolagem
            return SingleChildScrollView(
              child: Column(
                children: [
                  newChatButton,
                  const SizedBox(height: 24),
                  profileCard,
                  const SizedBox(height: 24),
                  scoreCard,
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // Card de Perfil
  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Perfil', style: AppTextStyles.h1.copyWith(color: AppColors.textDark, fontSize: 32)),
          const SizedBox(height: 24),
          Text('Nome', style: AppTextStyles.caption.copyWith(color: Colors.grey.shade600)),
          const SizedBox(height: 4),
          const Text('Fulano', style: TextStyle(fontSize: 16, color: AppColors.textDark)),
          const SizedBox(height: 16),
          Text('Email', style: AppTextStyles.caption.copyWith(color: Colors.grey.shade600)),
          TextFormField(
            initialValue: 'exemplo@gmail.com',
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {},
            child: const Text('Alterar senha', style: TextStyle(color: AppColors.gradientEnd)),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(onPressed: () {}, child: const Text('Sair')),
              const SizedBox(width: 8),
              ElevatedButton(onPressed: () {}, child: const Text('Salvar')),
            ],
          ),
        ],
      ),
    );
  }

  // Card de Score
  Widget _buildScoreCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Seu Score', style: AppTextStyles.h1.copyWith(color: AppColors.textDark, fontSize: 32)),
          const SizedBox(height: 24),
          // ** SUBSTITUA O ÍCONE PELA SUA IMAGEM DO MEDIDOR **
          // Ex: Image.asset('assets/images/score_meter.png'),
          const Center(
            child: Icon(Icons.speed, size: 150, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Center(child: Text('600 de 1000', style: AppTextStyles.h2)),
          const SizedBox(height: 8),
          Center(
            child: Chip(
              label: const Text('Médio'),
              backgroundColor: Colors.yellow.shade600,
              labelStyle: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 24),
          Text('Impactos', style: AppTextStyles.h2),
          const SizedBox(height: 16),
          _buildImpactItem(
              'Pode melhorar', Colors.red.shade100, Icons.warning_amber_rounded, Colors.red, []),
          const SizedBox(height: 16),
          _buildImpactItem(
            'Pontos positivos',
            Colors.green.shade100,
            Icons.check_circle,
            Colors.green,
            ['Pagamentos em dia', 'Pagamentos em dia'],
          ),
        ],
      ),
    );
  }

  // Item de Impacto (Positivo ou a Melhorar)
  Widget _buildImpactItem(String title, Color bgColor, IconData icon, Color iconColor, List<String> items) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
                if (items.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  ...items.map((item) => Text('• $item', style: const TextStyle(color: AppColors.textDark))),
                ]
              ],
            ),
          ),
          Icon(icon, color: iconColor),
        ],
      ),
    );
  }

  // Botão de Novo Chat
  Widget _buildNewChatButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: TextButton(
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Novo chat', style: AppTextStyles.normal.copyWith(fontSize: 20)),
              const Icon(Icons.add, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}