import 'package:flutter/material.dart';
import 'chat_page.dart';
import 'image_page.dart';
import 'voice_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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