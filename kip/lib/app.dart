import 'package:flutter/material.dart';
import 'package:kip/screens/chat_screen.dart';
import 'package:kip/screens/onboarding_screen.dart'; 
import 'package:kip/screens/card_test_screen.dart'; 

class SmartAssistantApp extends StatelessWidget {
  const SmartAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assistente Inteligente',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color(0xFFC50000), // Fundo vermelho padrão
        fontFamily: 'Roboto', // Exemplo de fonte, pode ser customizada
      ),
      home: const OnboardingScreen(),
    );
  }
}