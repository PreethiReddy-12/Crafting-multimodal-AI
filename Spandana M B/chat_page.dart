import 'package:flutter/material.dart';
import 'package:flutter_gen_ai_chat_ui/flutter_gen_ai_chat_ui.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatPage extends StatelessWidget {
  final model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: 'AIzaSyD4j_tzCsyI24FwStj_c-JH903DEgGlImI',
  );

  @override
  Widget build(BuildContext context) {
    return LlmChatView(
      model: model,
      enableMic: false,
    );
  }
}