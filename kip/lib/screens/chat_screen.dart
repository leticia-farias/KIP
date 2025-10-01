import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../services/assistant_service.dart';
import '../widgets/message_bubble.dart';

/// Tela principal do chat do assistente.
/// Contém a lista de mensagens e área de input de texto.
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  /// Instancia o serviço que comunica com o backend
  final AssistantService _service =
      AssistantService(apiUrl: 'https://backend-assistente-a5hj.onrender.com/');

  @override
  void initState() {
    super.initState();
    // Mensagem inicial de boas-vindas
    _messages.add(ChatMessage(
        text:
            'Olá! Sou seu assistente de planos. Diga-me o que você precisa (ex: "Quero dados móveis até 100 reais").',
        isUser: false));
  }

  /// Envia mensagem do usuário e busca sugestões da IA
  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _isLoading) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _controller.clear();
      _isLoading = true;
    });

    try {
      final suggestions = await _service.getSuggestions(text);
      setState(() {
        _messages.add(ChatMessage(
            text: suggestions.isEmpty
                ? 'Não encontrei sugestões.'
                : 'Sugestões encontradas:',
            isUser: false,
            suggestions: suggestions));
      });
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
            text: 'Erro ao conectar com o servidor: $e', isUser: false));
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assistente Inteligente (Gemini)'),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) =>
                  MessageBubble(message: _messages[_messages.length - 1 - index]),
            ),
          ),
          const Divider(height: 1),
          _buildInputArea(),
        ],
      ),
    );
  }

  /// Área de input de texto e botão de envio
  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Theme.of(context).cardColor,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration.collapsed(
                  hintText: 'Digite sua necessidade'),
              onSubmitted: (_) => _sendMessage(),
              enabled: !_isLoading,
            ),
          ),
          IconButton(
            icon: _isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.send, color: Colors.blue),
            onPressed: _isLoading ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}