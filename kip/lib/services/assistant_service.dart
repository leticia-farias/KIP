// kip/lib/services/assistant_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/package.dart';

class AssistantService {
  final String apiUrl;

  AssistantService({required this.apiUrl});

  Future<List<Package>> getSuggestions(String userText, {double budget = 999.0}) async {
    final payload = jsonEncode({'needs': userText, 'budget': budget});

    // --- INÍCIO DA MODIFICAÇÃO DE DIAGNÓSTICO ---
    print('--- ENVIANDO PARA O BACKEND ---');
    print('URL: ${apiUrl}packages/suggest');
    print('Payload: $payload');
    // --- FIM DA MODIFICAÇÃO ---

    try {
      final response = await http.post(
        Uri.parse(apiUrl + 'packages/suggest'),
        headers: {'Content-Type': 'application/json'},
        body: payload,
      );

      // --- INÍCIO DA MODIFICAÇÃO DE DIAGNÓSTICO ---
      print('--- RESPOSTA DO BACKEND ---');
      print('Status Code: ${response.statusCode}');
      print('Corpo da Resposta: ${response.body}');
      // --- FIM DA MODIFICAÇÃO ---

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['success'] == true && data.containsKey('suggestions')) {
          final suggestions = (data['suggestions'] as List)
              .map((json) => Package.fromJson(json))
              .toList();
          print('Sugestões parseadas com sucesso: ${suggestions.length} itens.');
          return suggestions;
        }
        print('Resposta com sucesso, mas sem sugestões.');
        return [];
      } else {
        throw Exception('Erro no servidor: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro de conexão ou parsing: $e');
      rethrow;
    }
  }
}