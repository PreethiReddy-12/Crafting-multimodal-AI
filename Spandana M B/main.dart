import 'package:flutter/material.dart';
import 'package:gen_ai_fusion/chat_page.dart';
import 'package:gen_ai_fusion/image_page.dart';
import 'package:gen_ai_fusion/voice_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GenAI Craft Fusion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GenAITabHome(),
    );
  }
}

class GenAITabHome extends StatelessWidget {
  const GenAITabHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GenAI Craft Fusion'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.chat), text: 'Chat'),
              Tab(icon: Icon(Icons.image), text: 'Image'),
              Tab(icon: Icon(Icons.mic), text: 'Voice'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ChatPage(),
            ImagePage(),
            VoicePage(),
          ],
        ),
      ),
    );
  }
}