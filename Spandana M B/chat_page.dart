import 'package:flutter/material.dart';
import 'package:flutter_gen_ai_chat_ui/flutter_gen_ai_chat_ui.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: 'AIzaSyD4j_tzCsyI24FwStj_c-JH903DEgGlImI', // Replace with your actual API key
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini Chat'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: LlmChatView(
        model: model,
        enableMic: false,
      ),
    );
  }
}