import 'package:flutter/material.dart';
import 'package:kip/models/package.dart';
import 'package:kip/widgets/confirm_button.dart';

class CardItem extends StatelessWidget {
  final Package package;
  final VoidCallback onAccept;
  final VoidCallback onNegotiate;

  const CardItem({
    super.key,
    required this.package,
    required this.onAccept,
    required this.onNegotiate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Oferta para você', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24), // marginBetweenSections
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Plano', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(package.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Preço', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(
                      'R\$ ${package.price.toStringAsFixed(2).replaceAll('.', ',')}/mês',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onNegotiate,
                    child: const Text('Negociar'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ConfirmButton(
                    text: 'Aceitar',
                    onPressed: onAccept,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}