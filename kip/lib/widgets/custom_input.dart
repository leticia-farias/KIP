import 'package:flutter/material.dart';
import 'package:kip/core/theme/app_colors.dart';
import 'package:kip/core/theme/app_text_styles.dart'; 
import 'package:speech_to_text/speech_to_text.dart';

class CustomInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isLoading;
  final VoidCallback onSend;

  const CustomInput({
    super.key,
    required this.controller,
    this.hintText = "Digite ou fale",
    this.isLoading = false,
    required this.onSend,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _isTyping = false;
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
    _initSpeech();
  }
  
  // Método para inicializar o SpeechToText
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  // Método para iniciar a escuta
  void _startListening() async {
    await _speechToText.listen(
      listenFor: const Duration(seconds: 30),
      localeId: "pt_BR", 
      onResult: (result) {
        setState(() {
          widget.controller.text = result.recognizedWords;
          widget.controller.selection = TextSelection.fromPosition(
            TextPosition(offset: widget.controller.text.length),
          );
        });
      },
    );
    setState(() {
      _isListening = true;
    });
  }

  // Método para parar a escuta
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _isListening = false;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final isTyping = widget.controller.text.isNotEmpty;
    if (isTyping != _isTyping) {
      setState(() {
        _isTyping = isTyping;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(12),
      shadowColor: Colors.black.withAlpha(6),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              cursorColor: AppColors.gradientStart,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                fillColor: AppColors.white,
                hintText: widget.hintText,
                hintStyle: AppTextStyles.hintText,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: _isTyping
                    ? null
                    : IconButton(
                        icon: Icon(
                          _isListening ? Icons.mic_off : Icons.mic,
                          color: Colors.grey,
                        ),
                        onPressed: _speechEnabled
                          ? _speechToText.isNotListening ? _startListening : _stopListening
                          : null,
                      ),
              ),
              onSubmitted: (_) => widget.onSend(),
              enabled: !widget.isLoading,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: widget.isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : _isTyping
                    ? IconButton(
                        icon: const Icon(Icons.send, color: AppColors.gradientStart),
                        onPressed: widget.onSend,
                      )
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}