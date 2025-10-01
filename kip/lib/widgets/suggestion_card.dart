import 'package:flutter/material.dart';
import '../models/package.dart';

/// Card que exibe as informações de um pacote sugerido.
class SuggestionCard extends StatelessWidget {
  final Package pkg;

  const SuggestionCard({super.key, required this.pkg});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pkg.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blueAccent)),
            const Divider(height: 8, color: Colors.grey),
            _featureRow('Tipo:', pkg.type == 'mobile_data' ? 'Dados Móveis' : 'Internet Fixa'),
            _featureRow('Preço:', 'R\$${pkg.price.toStringAsFixed(2)}'),
            _featureRow('Características:', pkg.features),
            const SizedBox(height: 4),
            Text(pkg.description,
                style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  Widget _featureRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 4),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}