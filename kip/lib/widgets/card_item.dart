import 'package:flutter/material.dart';
import 'package:kip/core/theme/app_colors.dart';
import 'package:kip/core/theme/app_text_styles.dart';
import 'package:kip/models/package.dart';
import 'package:kip/widgets/confirm_button.dart';

class SuggestionCard extends StatelessWidget {
  final Package pkg;

  const SuggestionCard({super.key, required this.pkg});

  @override
  Widget build(BuildContext context) {
    final String planDetails = '${pkg.name} + ${pkg.features}';

    return Card(
      color: AppColors.buttonPrimary,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          // Garante que o botão ocupe toda a largura
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // Faz o card ter o tamanho do seu conteúdo
          mainAxisSize: MainAxisSize.min,
          children: [
            // Título: "Nova oferta para você"
            Text(
              'Nova oferta para você',
              style: AppTextStyles.h2.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 24),

            // Linha com as colunas de Plano e Preço
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Coluna do Plano
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Plano',
                        style: AppTextStyles.h4.copyWith(
                            color: Colors.grey.shade600, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        planDetails,
                        style: AppTextStyles.h2.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // Coluna do Preço
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Preço',
                      style: AppTextStyles.h4
                          .copyWith(color: Colors.grey.shade600, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'R\$ ${pkg.price.toStringAsFixed(2).replaceAll('.', ',')}/mês',
                      style: AppTextStyles.h2.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Botão Aceitar
            ConfirmButton(
              text: 'Aceitar',
              onPressed: () {
                // Ação para o botão Aceitar
                print('Oferta aceita: ${pkg.name}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
