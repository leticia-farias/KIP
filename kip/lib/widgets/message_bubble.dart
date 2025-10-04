import 'package:flutter/material.dart';
import 'package:kip/core/theme/app_colors.dart';
import '../models/chat_message.dart';
import 'package:kip/core/theme/app_text_styles.dart';
import 'suggestion_card.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;
    final bubbleColor = AppColors.white;
    final textColor = AppColors.textDark;

    return Container(
      alignment: alignment,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!isUser)
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                'Assistente inteligente',
                style: AppTextStyles.h4.copyWith(color: AppColors.textLight),
              ),
            ),
          Container(
            padding: const EdgeInsets.all(12),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.only(
                topLeft: isUser ? const Radius.circular(20) : Radius.zero,
                topRight: const Radius.circular(20),
                bottomLeft: const Radius.circular(20),
                bottomRight: isUser ? Radius.zero : const Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: AppTextStyles.h4.copyWith(color: AppColors.textDark),
                ),
                if (message.suggestions != null &&
                    message.suggestions!.isNotEmpty)
                  ...message.suggestions!.map((pkg) => Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SuggestionCard(pkg: pkg),
                      )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
