import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class VoicePage extends StatefulWidget {
  const VoicePage({super.key});

  @override
  State<VoicePage> createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  final SpeechToText _speech = SpeechToText();
  final FlutterTts _tts = FlutterTts();

  final model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: 'AIzaSyD4j_tzCsyI24FwStj_c-JH903DEgGlImI', // ⚠️ Consider securing this key
  );

  String _transcription = '';
  String _response = '';

  Future<void> _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      _speech.listen(onResult: (result) async {
        setState(() => _transcription = result.recognizedWords);

        final response = await model.generateContent([
          Content.text(_transcription),
        ]);

        setState(() => _response = response.text ?? 'No response received.');
        await _tts.speak(_response);
      });
    } else {
      setState(() => _response = 'Speech recognition not available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voice Assistant')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _startListening,
              child: const Text('Speak'),
            ),
            const SizedBox(height: 20),
            Text('You said: $_transcription'),
            const SizedBox(height: 10),
            Text('AI says: $_response'),
          ],
        ),
      ),
    );
  }
}