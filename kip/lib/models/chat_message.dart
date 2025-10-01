import 'package:kip/models/package.dart';

/// Modelo que representa uma mensagem no chat.
/// Pode ser do usuário ou da IA e conter sugestões de pacotes.
class ChatMessage {
  final String text;                // Conteúdo da mensagem
  final bool isUser;                // Se é mensagem do usuário
  final List<Package>? suggestions; // Sugestões de pacotes, se houver

  ChatMessage({required this.text, required this.isUser, this.suggestions});
}