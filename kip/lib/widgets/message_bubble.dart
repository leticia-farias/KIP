import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import 'suggestion_card.dart';

/// Widget que exibe uma bolha de mensagem do chat.
/// Pode conter texto simples ou sugestões de pacotes.
class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;
    final color = isUser ? Colors.blue.shade100 : Colors.grey.shade200;

    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message.text,
                    style: TextStyle(
                        fontWeight:
                            isUser ? FontWeight.normal : FontWeight.bold)),
                if (message.suggestions != null)
                  ...message.suggestions!
                      .map((pkg) => Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: SuggestionCard(pkg: pkg),
                          ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}