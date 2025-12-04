import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'gallery_screen.dart'; // ← ИМПОРТ
import 'character_selection_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My AI Girlfriend',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      ),
      initialRoute: CharacterSelectionScreen.routeName,
      routes: {
        '/gallery': (context) => GalleryScreen(), // ← Исправлено!
        CharacterSelectionScreen.routeName: (context) => const CharacterSelectionScreen(),
        '/chat': (context) => ChatScreen(
          character: ModalRoute.of(context)!.settings.arguments as Character,
        ),
      },
    );
  }
}