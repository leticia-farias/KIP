import 'package:flutter/material.dart';
import 'package:kip/core/theme/app_colors.dart';
import 'package:kip/core/theme/app_text_styles.dart';
import 'package:kip/models/package.dart';
import 'package:kip/widgets/confirm_button.dart';
import 'package:kip/screens/cadastro_screen.dart';

class SuggestionCard extends StatelessWidget {
  final Package pkg;
  final bool isDesktop;

  const SuggestionCard({
    super.key,
    required this.pkg,
    this.isDesktop = false, 
  });

  @override
  Widget build(BuildContext context) {
    final String planDetails = '${pkg.name} + ${pkg.features}';

    return Card(
      color: AppColors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nova oferta para você',
              style: AppTextStyles.h2.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 24),

            _buildResponsiveContent(planDetails),

            const SizedBox(height: 32),
            ConfirmButton(
              text: 'Aceitar',
              onPressed: () {
                // 2. Adicione a lógica de navegação aqui
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CadastroScreen(package: pkg),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // 3. Método que decide qual layout construir
  Widget _buildResponsiveContent(String planDetails) {
    final planInfo = _buildInfoColumn('Plano', planDetails, CrossAxisAlignment.start);
    final priceInfo = _buildInfoColumn(
        'Preço', 'R\$ ${pkg.price.toStringAsFixed(2).replaceAll('.', ',')}/mês', CrossAxisAlignment.start);

    if (isDesktop) {
      // Layout para Desktop (Duas colunas)
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: planInfo),
          const SizedBox(width: 16),
          priceInfo,
        ],
      );
    } else {
      // Layout para Mobile (Empilhado)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          planInfo,
          const SizedBox(height: 16),
          priceInfo,
        ],
      );
    }
  }

  // 4. Widget auxiliar para evitar repetição de código
  Widget _buildInfoColumn(String title, String value, CrossAxisAlignment alignment) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          title,
          style: AppTextStyles.h4.copyWith(color: Colors.grey.shade600, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTextStyles.h2.copyWith(fontSize: 18),
          textAlign: alignment == CrossAxisAlignment.end ? TextAlign.right : TextAlign.left,
        ),
      ],
    );
  }
}