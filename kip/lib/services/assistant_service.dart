import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/package.dart';

/// Serviço responsável por se comunicar com o backend Dart
/// para obter sugestões de pacotes.
class AssistantService {
  final String apiUrl;

  AssistantService({required this.apiUrl});

  /// Faz requisição ao backend passando o texto do usuário
  /// e retorna uma lista de [Package] sugeridos.
  Future<List<Package>> getSuggestions(String userText, {double budget = 999.0}) async {
    final payload = jsonEncode({'needs': userText, 'budget': budget});

    try {
      final response = await http.post(
        Uri.parse(apiUrl + 'packages/suggest'), // URL completa para o POST
        headers: {'Content-Type': 'application/json'},
        body: payload,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['success'] == true && data.containsKey('suggestions')) {
          return (data['suggestions'] as List)
              .map((json) => Package.fromJson(json))
              .toList();
        }

        return [];
      } else {
        throw Exception('Erro no servidor: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro de conexão ou parsing: $e');
      rethrow; // propaga o erro para o UI tratar
    }
  }
}