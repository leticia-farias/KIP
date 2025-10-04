import 'package:flutter/material.dart';
import 'package:kip/core/layout/base_layout.dart';
import 'package:kip/core/theme/app_colors.dart';
import 'package:kip/core/theme/app_text_styles.dart';
import 'package:kip/models/package.dart';
import 'package:kip/widgets/confirm_button.dart';
import 'package:kip/screens/Score_screen.dart';

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
              style: AppTextStyles.h2,
            ),
          );

          final valueCard = _buildInfoCard(
            title: 'Valor final',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'R\$ ${package.price.toStringAsFixed(2).replaceAll('.', ',')}/mês',
                  style: AppTextStyles.h1,
                ),
                const SizedBox(height: 8),
                Text(
                  'Cobrança mensal, cancele quando quiser',
                  style: AppTextStyles.h4
                      .copyWith(color: Colors.grey.shade600),
                ),
              ],
            ),
          );

          final paymentCard = _buildPaymentCard(context);

          if (isDesktop) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 960),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
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
                    Expanded(
                      flex: 1,
                      child: paymentCard,
                    ),
                  ],
                ),
              ),
            );
          } else {
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
      width: double.infinity, 
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
            style: AppTextStyles.h4.copyWith(color: Colors.grey.shade600),
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
            style: AppTextStyles.h4.copyWith(color: Colors.grey.shade600),
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
            style: AppTextStyles.h4.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),
          ConfirmButton(
            text: 'Confirmar assinatura',
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const ScoreScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
