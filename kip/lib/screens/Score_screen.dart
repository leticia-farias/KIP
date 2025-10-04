import 'package:flutter/material.dart';
import 'package:kip/core/layout/base_layout.dart';
import 'package:kip/core/theme/app_colors.dart';
import 'package:kip/core/theme/app_text_styles.dart';
import 'package:kip/screens/chat_screen.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseLayout(
        builder: (context, values) {
          final isDesktop = values.isDesktop;
          final scoreCard = _buildScoreCard(context); // Passando o context
          final actionButtons = _buildActionButtons(context);

          if (isDesktop) {
            // Layout para Desktop
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1080),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: scoreCard,
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 5,
                      child: actionButtons,
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Layout para Mobile
            return SingleChildScrollView(
              child: Column(
                children: [
                  actionButtons,
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

  // Agrupa os botões de ação
  Widget _buildActionButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildActionButton(label: 'Perfil', onTap: () {}),
        const SizedBox(height: 16),
        _buildActionButton(label: 'Assinatura', onTap: () {}),
        const SizedBox(height: 16),
        _buildActionButton(
          label: 'Novo chat',
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const ChatScreen(),
            ));
          },
          hasIcon: true,
        ),
      ],
    );
  }

  // Widget para os botões de ação
  Widget _buildActionButton(
      {required String label, required VoidCallback onTap, bool hasIcon = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: AppTextStyles.h4.copyWith(color: Colors.white, fontSize: 18)),
            if (hasIcon)
              const Icon(Icons.add, color: Colors.white, size: 28),
          ],
        ),
      ),
    );
  }

  // Cartão com a pontuação e os impactos (com scroll interno)
  Widget _buildScoreCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      // 1. Adicionamos uma restrição de altura máxima
      constraints: BoxConstraints(
        // O card poderá ocupar no máximo 70% da altura da tela
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      // 2. Adicionamos a rolagem interna
      child: SingleChildScrollView(
        child: Column(
          // mainAxisSize.min garante que a coluna não tente se esticar desnecessariamente
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Seu Score',
                style: AppTextStyles.h1.copyWith(color: AppColors.textDark, fontSize: 24)),
            const SizedBox(height: 24),
            _buildScoreGauge(600), // Pontuação de exemplo
            const SizedBox(height: 24),
            Text('Impactos',
                style: AppTextStyles.h2.copyWith(color: AppColors.textDark, fontSize: 18)),
            const SizedBox(height: 16),
            _buildImpactItem('Pode melhorar', Colors.red.shade50,
                Icons.warning_amber_rounded, Colors.red, []),
            const SizedBox(height: 12),
            _buildImpactItem(
                'Pontos positivos',
                Colors.green.shade50,
                Icons.check_circle,
                Colors.green,
                ['Pagamentos em dia', 'Bom uso do crédito', 'Vários anos de histórico']),
          ],
        ),
      ),
    );
  }

  // Medidor de pontuação
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
        SizedBox(
          height: 200,
          child: SfRadialGauge(axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 1000,
              showLabels: false,
              showTicks: false,
              startAngle: 180,
              endAngle: 0,
              axisLineStyle: const AxisLineStyle(
                  thickness: 20, cornerStyle: CornerStyle.bothCurve),
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
                GaugeRange(
                    startValue: 0,
                    endValue: 300,
                    color: Colors.red,
                    startWidth: 20,
                    endWidth: 20),
                GaugeRange(
                    startValue: 300,
                    endValue: 700,
                    color: Colors.orange,
                    startWidth: 20,
                    endWidth: 20),
                GaugeRange(
                    startValue: 700,
                    endValue: 1000,
                    color: Colors.green,
                    startWidth: 20,
                    endWidth: 20),
              ],
            )
          ]),
        ),
        Text('${score.toInt()} de 1000',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Chip(
          label: Text(label, style: const TextStyle(color: Colors.white)),
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ],
    );
  }

  // Itens de impacto (pontos positivos e a melhorar) - AGORA RECOLHÍVEIS
  Widget _buildImpactItem(String title, Color bgColor, IconData icon,
      Color iconColor, List<String> items) {
    // Se a lista de itens estiver vazia, retorna um card simples (não expansível)
    if (items.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.textDark)),
            ),
          ],
        ),
      );
    }

    // Se houver itens, retorna um card expansível (ExpansionTile)
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.textDark)),
        iconColor: AppColors.textDark,
        collapsedIconColor: AppColors.textDark,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: items
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('• $item',
                            style: const TextStyle(color: AppColors.textDark)),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}