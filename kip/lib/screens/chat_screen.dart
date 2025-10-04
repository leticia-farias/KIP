import 'package:flutter/material.dart';
import 'package:kip/core/layout/base_layout.dart';
import 'package:kip/models/chat_message.dart';
import 'package:kip/services/assistant_service.dart';
import 'package:kip/widgets/custom_input.dart';
import 'package:kip/widgets/message_bubble.dart';

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

    // Se uma mensagem inicial for passada, envia ela imediatamente.
    if (widget.initialMessage != null && widget.initialMessage!.isNotEmpty) {
      _controller.text = widget.initialMessage!;
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
      _messages.insert(0, ChatMessage(text: text, isUser: true));
      _controller.clear();
      _isLoading = true;
    });

    try {
      final suggestions = await _service.getSuggestions(text);
      if (mounted) {
        setState(() {
          _messages.insert(
              0,
              ChatMessage(
                  text: suggestions.isEmpty
                      ? 'Não encontrei sugestões para sua solicitação.'
                      : 'Com base no que você pediu, encontrei as seguintes opções:',
                  isUser: false,
                  suggestions: suggestions));
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _messages.insert(
              0,
              ChatMessage(
                  text:
                      'Desculpe, tive um problema para me conectar. Tente novamente mais tarde.',
                  isUser: false));
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
      body: BaseLayout(
        builder: (context, values) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return MessageBubble(message: _messages[index]);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomInput(
                  controller: _controller,
                  isLoading: _isLoading,
                  onSend: _sendMessage,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

