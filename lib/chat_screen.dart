import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'character_selection_screen.dart'; // импорт Character из экрана выбора

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class ChatScreen extends StatefulWidget {
  final Character character;

  const ChatScreen({super.key, required this.character});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  late List<ChatMessage> _messages;

  @override
  void initState() {
    super.initState();
    _messages = [
      ChatMessage(
        text: 'Привет! Я — ${widget.character.name}. ${widget.character.description}',
        isUser: false,
      ),
    ];
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
    });
    _textController.clear();

    _generateAIResponse(text, widget.character).then((aiResponse) {
      setState(() {
        _messages.add(ChatMessage(text: aiResponse, isUser: false));
      });
    }).catchError((error) {
      setState(() {
        _messages.add(ChatMessage(text: 'Ошибка: $error', isUser: false));
      });
    });
  }

  Future<String> _generateAIResponse(String userMessage, Character character) async {
    // 🔑 ВСТАВЬТЕ СЮДА ВАШ НАСТОЯЩИЙ API-КЛЮЧ ОТ OPENROUTER!
    final String apiKey = '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';

    final String prompt = '''
Ты — ${character.name}. ${character.description}
Ты ведёшь личную, тёплую беседу с человеком. Отвечай кратко (1–2 предложения), эмоционально, на русском языке.
Не пиши, что ты ИИ. Не используй формальностей. Будь живой и в стиле персонажа!

Сообщение: "$userMessage"
Твой ответ:
''';

    final response = await http.post(
      Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
        'HTTP-Referer': 'http://localhost:3000',
        'X-Title': 'My AI Girlfriend',
      },
      body: jsonEncode({
        'model': 'mistralai/mistral-7b-instruct:free', // ✅ правильное имя модели
        'messages': [{'role': 'user', 'content': prompt}],
        'max_tokens': 150,
        'temperature': 0.8,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes); // ✅ явное декодирование в UTF-8
      final data = jsonDecode(responseBody);
      return data['choices'][0]['message']['content'].trim();
    } else {
      final errorData = jsonDecode(utf8.decode(response.bodyBytes)); // ✅ и в ошибке тоже
      final message = errorData['error']['message'] ?? 'Неизвестная ошибка';
      throw 'Ошибка ИИ: $message (код ${response.statusCode})';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.character.name),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:
                  message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxWidth: 240),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: message.isUser ? Colors.blueAccent : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message.text,
                        style: TextStyle(
                          color: message.isUser ? Colors.white : Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: "Напиши сообщение...",
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: _handleSubmitted,
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () => _handleSubmitted(_textController.text),
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}