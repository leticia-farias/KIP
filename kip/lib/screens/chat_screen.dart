import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../services/assistant_service.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  // 1. Adicionar um parâmetro para a mensagem inicial
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
    _messages.add(ChatMessage(
        text:
            'Olá! Sou seu assistente de planos. Diga-me o que você precisa (ex: "Quero dados móveis até 100 reais").',
        isUser: false));

    // 2. Lógica para processar a mensagem inicial, se ela existir
    if (widget.initialMessage != null && widget.initialMessage!.isNotEmpty) {
      // Adiciona a mensagem ao controlador e chama a função de envio
      _controller.text = widget.initialMessage!;
      _sendMessage();
    }
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
      setState(() {
        _messages.add(ChatMessage(
            text: suggestions.isEmpty
                ? 'Não encontrei sugestões.'
                : 'Encontrei estas sugestões para você:',
            isUser: false,
            suggestions: suggestions));
      });
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
            text: 'Erro ao conectar com o servidor: $e', isUser: false));
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // O resto do build continua igual...
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assistente Inteligente'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFC50000), // Cor de fundo do app
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // Mantém as mensagens mais recentes visíveis
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                // Inverte a lista para exibir corretamente com reverse: true
                final reversedIndex = _messages.length - 1 - index;
                return MessageBubble(message: _messages[reversedIndex]);
              },
            ),
          ),
          const Divider(height: 1),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    // ... O método _buildInputArea() continua o mesmo
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