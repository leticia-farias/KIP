import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';

/// Configura o MaterialApp, definindo tema, título e tela inicial.
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