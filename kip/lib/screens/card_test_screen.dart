import 'package:flutter/material.dart';
import 'package:kip/core/layout/base_layout.dart';
import 'package:kip/models/package.dart';
import 'package:kip/widgets/suggestion_card.dart';

class CardTestScreen extends StatelessWidget {
  const CardTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final samplePackage = Package(
      name: 'Internet Fibra 100 Mega',
      description: 'Uma oferta especial para você aproveitar a melhor conexão.',
      type: 'fixed_internet',
      price: 39.90,
      features: '2x de dados por 3 meses',
    );

    return BaseLayout(
      builder: (context, values) {
        return Center(
          child: SizedBox(
            width: 500,
            // 1. Passe o valor 'isDesktop' para o widget do card
            child: SuggestionCard(
              pkg: samplePackage,
              isDesktop: values.isDesktop,
            ),
          ),
        );
      },
    );
  }
}