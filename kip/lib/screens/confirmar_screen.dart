import 'package:flutter/material.dart';
import 'package:kip/core/layout/base_layout.dart';
import 'package:kip/core/theme/app_colors.dart';
import 'package:kip/core/theme/app_text_styles.dart';
import 'package:kip/models/package.dart';
import 'package:kip/widgets/confirm_button.dart';
import 'package:kip/screens/profile_screen.dart';

class ConfirmarScreen extends StatelessWidget {
  final Package package;

  const ConfirmarScreen({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseLayout(
        builder: (context, values) {
          final isDesktop = values.isDesktop;

          final planCard = _buildInfoCard(
            title: 'Plano selecionado',
            child: Text(
              '${package.name} + ${package.features}',
              style: AppTextStyles.h2.copyWith(fontSize: 22),
            ),
          );

          final valueCard = _buildInfoCard(
            title: 'Valor final',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'R\$ ${package.price.toStringAsFixed(2).replaceAll('.', ',')}/mês',
                  style: AppTextStyles.h1
                      .copyWith(color: AppColors.textDark, fontSize: 32),
                ),
                const SizedBox(height: 8),
                Text(
                  'Cobrança mensal, cancele quando quiser',
                  style: AppTextStyles.caption
                      .copyWith(color: Colors.grey.shade600),
                ),
              ],
            ),
          );

          final paymentCard = _buildPaymentCard(context);

          if (isDesktop) {
            // Layout para Desktop
            return Center(
              // 1. Adicionado um limite de largura máxima
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 960),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 2. Trocado Flexible por Expanded
                    Expanded(
                      flex: 2, // A coluna da esquerda ocupa 2/3 do espaço
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          planCard,
                          const SizedBox(height: 24),
                          valueCard,
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    // 3. Trocado Flexible por Expanded
                    Expanded(
                      flex: 1, // A coluna da direita ocupa 1/3 do espaço
                      child: paymentCard,
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
                  planCard,
                  const SizedBox(height: 24),
                  valueCard,
                  const SizedBox(height: 24),
                  paymentCard,
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildInfoCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity, // Garante que o card preencha a coluna
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.caption.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _buildPaymentCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Forma de pagamento',
            style: AppTextStyles.caption.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cartão de crédito',
                style: AppTextStyles.h2.copyWith(fontSize: 22),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Pode alterar a forma',
            style: AppTextStyles.caption.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),
          ConfirmButton(
            text: 'Confirmar assinatura',
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const PerfilScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
