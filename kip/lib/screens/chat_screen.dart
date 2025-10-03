import 'package:flutter/material.dart';
import 'package:kip/core/layout/base_layout.dart';
import 'package:kip/widgets/custom_input.dart';
import '../models/chat_message.dart';
import '../services/assistant_service.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  final String? initialMessage;

  const ChatScreen({super.key, this.initialMessage});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  final AssistantService _service =
      AssistantService(apiUrl: 'https://backend-assistente-a5hj.onrender.com/');

  @override
  void initState() {
    super.initState();
    // Mensagem inicial de boas-vindas da IA
    _messages.add(ChatMessage(
        text:
            'Olá! Sou seu assistente de planos. Diga-me o que você precisa (ex: "Quero dados móveis até 100 reais").',
        isUser: false));

    // Se houver uma mensagem inicial da tela de onboarding, processa ela
    if (widget.initialMessage != null && widget.initialMessage!.isNotEmpty) {
      _controller.text = widget.initialMessage!;
      // Usamos um pequeno atraso para garantir que a UI construiu antes de enviar
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _sendMessage();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(
              text: suggestions.isEmpty
                  ? 'Não encontrei sugestões para sua solicitação.'
                  : 'Com base no que você pediu, indico o seguinte:',
              isUser: false,
              suggestions: suggestions));
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(
              text: 'Desculpe, tive um problema para me conectar ao servidor. Tente novamente mais tarde.', isUser: false));
        });
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Usando o BaseLayout como corpo principal
      body: BaseLayout(
        builder: (context, values) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  // reverse: true,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) =>
                      MessageBubble(message: _messages[index]),
                ),
              ),
              const SizedBox(height: 16), // Espaçamento antes do input
              // 2. Usando o CustomInput no lugar do _buildInputArea
              CustomInput(
                controller: _controller,
                isLoading: _isLoading,
                onSend: _sendMessage,
              ),
            ],
          );
        },
      ),
    );
  }
}