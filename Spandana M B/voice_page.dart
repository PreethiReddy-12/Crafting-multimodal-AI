import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class VoicePage extends StatefulWidget {
  const VoicePage({Key? key}) : super(key: key);

  @override
  State<VoicePage> createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  bool _isListening = false;
  String _text = 'Tap the mic and start speaking...';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();

    _flutterTts.setLanguage('en-US');
    _flutterTts.setPitch(1.0);
  }

  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => debugPrint('Speech status: $status'),
        onError: (error) => debugPrint('Speech error: $error'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
            });
          },
        );
      } else {
        setState(() {
          _text = 'Speech recognition not available';
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  Future<void> _speak() async {
    if (_text.isNotEmpty) {
      await _flutterTts.speak(_text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Assistant'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  _text,
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: 'mic',
                  onPressed: _listen,
                  tooltip: _isListening ? 'Stop Listening' : 'Start Listening',
                  child: Icon(_isListening ? Icons.stop : Icons.mic),
                ),
                FloatingActionButton(
                  heroTag: 'tts',
                  onPressed: _speak,
                  tooltip: 'Speak Text',
                  child: const Icon(Icons.volume_up),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}