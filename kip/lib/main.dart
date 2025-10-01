// Imports necessários
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// --- Modelos (Idênticos ao Backend) ---

/// Classe que representa um Pacote ou Plano de Serviço.
class Package {
  final String name;
  final String description;
  final String type;
  final double price;
  final String features;

  Package({
    required this.name,
    required this.description,
    required this.type,
    required this.price,
    required this.features,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      name: json['name'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      price: (json['price'] as num).toDouble(),
      features: json['features'] as String,
    );
  }

  /// Retorna uma string formatada para exibir no chat.
  String toChatString() {
    return '✅ **${name.toUpperCase()}**\n'
        'Tipo: ${type == 'mobile_data' ? 'Dados Móveis' : 'Internet Fixa'}\n'
        'Preço: R\$${price.toStringAsFixed(2)}\n'
        'Características: $features\n'
        'Descrição: $description';
  }
}

/// Representa uma mensagem no chat, podendo ser do Usuário ou da IA.
class ChatMessage {
  final String text;
  final bool isUser;
  final List<Package>? suggestions;

  ChatMessage({required this.text, required this.isUser, this.suggestions});
}

// --- Configuração da Aplicação ---

void main() {
  runApp(const SmartAssistantApp());
}

class SmartAssistantApp extends StatelessWidget {
  const SmartAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assistente Gemini de Planos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ChatScreen(),
    );
  }
}

// --- Tela Principal do Chat ---

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  // IMPORTANTE: URL do seu backend Dart.
  // Use o IP da sua máquina para testes em dispositivos reais, ou 'localhost' para Web/Desktop.
  final String _apiUrl = 'https://backend-assistente-a5hj.onrender.com/';

  @override
  void initState() {
    super.initState();
    // Mensagem de boas-vindas inicial da IA
    _messages.add(ChatMessage(
      text: 'Olá! Sou seu assistente de planos. Diga-me o que você precisa '
          '(ex: "Quero dados móveis até 100 reais" ou "Internet fixa para 2 pessoas").',
      isUser: false,
    ));
  }

  /// Função principal para enviar a mensagem do usuário e obter sugestões da IA.
  void _sendMessage() async {
  final text = _controller.text.trim();
  if (text.isEmpty || _isLoading) return;

  // Adiciona a mensagem do usuário no chat
  setState(() {
    _messages.add(ChatMessage(text: text, isUser: true));
    _controller.clear();
    _isLoading = true;
  });

  try {
    // 1. Prepara o payload JSON usando a mensagem do usuário
    final payload = jsonEncode({
      'needs': text,      // texto digitado pelo usuário
      'budget': 999.0,    // valor padrão, pode ajustar conforme backend
    });

    // 2. Faz a requisição HTTP POST para o backend
    final response = await http.post(
      Uri.parse(_apiUrl), // use a URL pública do backend (Render/Cloud Run)
      headers: {'Content-Type': 'application/json'},
      body: payload,       // envia o payload correto
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData['success'] == true &&
          responseData.containsKey('suggestions')) {
        // 3. Desserializa as sugestões JSON
        final List<dynamic> jsonSuggestions = responseData['suggestions'];
        final List<Package> suggestedPackages = jsonSuggestions
            .map((json) => Package.fromJson(json as Map<String, dynamic>))
            .toList();

        // 4. Adiciona a resposta da IA na tela
        setState(() {
          _messages.add(ChatMessage(
            text:
                'Com base na sua solicitação, encontrei as seguintes sugestões:',
            isUser: false,
            suggestions: suggestedPackages,
          ));
        });
      } else {
        // Resposta da IA com success=false
        setState(() {
          _messages.add(ChatMessage(
            text: responseData['message'] ??
                'A IA não conseguiu gerar sugestões.',
            isUser: false,
          ));
        });
      }
    } else {
      // Erro de servidor
      throw Exception('Erro no servidor Dart: ${response.statusCode}');
    }
  } catch (e) {
    // Erro de conexão
    print('Erro de comunicação HTTP: $e');
    setState(() {
      _messages.add(ChatMessage(
        text:
            'Erro de conexão: Verifique se o backend Dart está rodando em $_apiUrl. $e',
        isUser: false,
      ));
    });
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}
  // --- Widgets ---

  Widget _buildMessage(ChatMessage message) {
    final isUser = message.isUser;
    final alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;
    final color = isUser ? Colors.blue.shade100 : Colors.grey.shade200;

    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: isUser
                    ? const Radius.circular(16)
                    : const Radius.circular(4),
                bottomRight: isUser
                    ? const Radius.circular(4)
                    : const Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: TextStyle(
                    fontWeight: isUser ? FontWeight.normal : FontWeight.bold,
                  ),
                ),
                if (message.suggestions != null &&
                    message.suggestions!.isNotEmpty)
                  ...message.suggestions!.map((pkg) => Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: _buildSuggestionCard(pkg),
                      )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionCard(Package pkg) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pkg.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.blueAccent,
              ),
            ),
            const Divider(height: 8, color: Colors.grey),
            _buildFeatureRow('Tipo:',
                pkg.type == 'mobile_data' ? 'Dados Móveis' : 'Internet Fixa'),
            _buildFeatureRow('Preço:', 'R\$${pkg.price.toStringAsFixed(2)}'),
            _buildFeatureRow('Características:', pkg.features),
            const SizedBox(height: 4),
            Text(pkg.description,
                style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assistente Inteligente (Gemini)'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          // Lista de Mensagens do Chat
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[_messages.length - 1 - index]);
              },
            ),
          ),
          // Área de Entrada de Texto
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration.collapsed(
                          hintText:
                              'Digite sua necessidade (ex: "Quero fibra barata")'),
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
            ),
          ),
        ],
      ),
    );
  }
}
