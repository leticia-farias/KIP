import 'package:flutter/material.dart';
import 'package:kip/core/layout/base_layout.dart';
import 'package:kip/core/theme/app_colors.dart';
import 'package:kip/core/theme/app_text_styles.dart';
import 'package:kip/screens/chat_screen.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

// Renomeado para ScoreScreen
class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    if (user == null) {
      // Tela de fallback caso não haja usuário logado
      return const Scaffold(body: Center(child: Text('Nenhum usuário logado.')));
    }

    return Scaffold(
      body: BaseLayout(
        builder: (context, values) {
          final isDesktop = values.isDesktop;
          final scoreCard = _buildScoreCard(user);
          final profileCard = _buildProfileCard(user, authService);
          final newChatButton = _buildNewChatButton(context);

          if (isDesktop) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1080),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [profileCard, const SizedBox(height: 24), newChatButton],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(flex: 4, child: scoreCard),
                  ],
                ),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  profileCard,
                  const SizedBox(height: 24),
                  scoreCard,
                  const SizedBox(height: 24),
                  newChatButton,
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // TODOS OS MÉTODOS AUXILIARES ESTÃO AQUI DENTRO DA CLASSE:

  Widget _buildProfileCard(UserModel user, AuthService authService) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Perfil', style: AppTextStyles.h1.copyWith(color: AppColors.textDark, fontSize: 24)),
          const SizedBox(height: 24),
          Text('Nome', style: AppTextStyles.h4.copyWith(color: Colors.grey.shade600)),
          const SizedBox(height: 4),
          Text(user.name, style: const TextStyle(fontSize: 16, color: AppColors.textDark)),
          const SizedBox(height: 16),
          Text('Email', style: AppTextStyles.h4.copyWith(color: Colors.grey.shade600)),
          const SizedBox(height: 4),
          TextFormField(
            initialValue: user.email,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(onPressed: () {}, child: const Text('Alterar senha', style: TextStyle(color: AppColors.gradientEnd))),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => authService.logout(),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.gradientStart),
                child: const Text('Sair', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                child: const Text('Salvar', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildScoreCard(UserModel user) {
     return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Seu Score', style: AppTextStyles.h1.copyWith(color: AppColors.textDark, fontSize: 24)),
          const SizedBox(height: 24),
          if (user.score == null)
             _buildUndefinedScore()
          else
            _buildScoreGauge(user.score!.toDouble()),
          const SizedBox(height: 24),
          Text('Impactos', style: AppTextStyles.h2.copyWith(color: AppColors.textDark, fontSize: 18)),
          const SizedBox(height: 16),
          _buildImpactItem('Pode melhorar', Colors.red.shade50, Icons.warning_amber_rounded, Colors.red, []),
          const SizedBox(height: 12),
          _buildImpactItem('Pontos positivos', Colors.green.shade50, Icons.check_circle, Colors.green, ['Pagamentos em dia']),
        ],
      ),
    );
  }

  Widget _buildUndefinedScore() {
    return const Center(
      child: Column(
        children: [
          Icon(Icons.help_outline, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text('Score Indefinido', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey)),
           SizedBox(height: 8),
          Text('Continue usando nossos serviços para gerarmos seu score.', textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildNewChatButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => const ChatScreen(),
        ));
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.gradientEnd.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Novo chat', style: AppTextStyles.h4.copyWith(color: Colors.white, fontSize: 18)),
            const Icon(Icons.add, color: Colors.white, size: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreGauge(double score) {
    String label;
    Color color;
    if (score < 300) {
      label = 'Baixo';
      color = Colors.red;
    } else if (score < 700) {
      label = 'Médio';
      color = Colors.orange;
    } else {
      label = 'Excelente';
      color = Colors.green;
    }

    return Column(
      children: [
        SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 1000,
            showLabels: false,
            showTicks: false,
            startAngle: 180,
            endAngle: 0,
            axisLineStyle: const AxisLineStyle(thickness: 20, cornerStyle: CornerStyle.bothCurve),
            pointers: <GaugePointer>[
              NeedlePointer(
                value: score,
                enableAnimation: true,
                needleStartWidth: 1,
                needleEndWidth: 5,
                needleLength: 0.7,
                knobStyle: const KnobStyle(knobRadius: 0.08),
              )
            ],
            ranges: <GaugeRange>[
              GaugeRange(startValue: 0, endValue: 300, color: Colors.red, startWidth: 20, endWidth: 20),
              GaugeRange(startValue: 300, endValue: 700, color: Colors.orange, startWidth: 20, endWidth: 20),
              GaugeRange(startValue: 700, endValue: 1000, color: Colors.green, startWidth: 20, endWidth: 20),
            ],
          )
        ]),
        Text('${score.toInt()} de 1000', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Chip(
          label: Text(label, style: const TextStyle(color: Colors.white)),
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ],
    );
  }

  Widget _buildImpactItem(String title, Color bgColor, IconData icon, Color iconColor, List<String> items) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
}