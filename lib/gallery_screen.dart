import 'package:flutter/material.dart';
import 'character_selection_screen.dart'; // для Character

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  // Список персонажей — внутри класса как статическое поле
  static final List<Character> _characters = [
    Character(
      name: 'Лиза',
      profession: 'Студентка-искусствовед из Парижа',
      hobbies: 'Музеи ночью, винтажные платья, французское кино',
      description: 'Мечтательная, интеллигентная, немного загадочная. Всегда ищет скрытый смысл.',
      imageUrl: 'assets/images/Liza.jpg',
    ),
    Character(
      name: 'Аня',
      profession: 'Студентка-биолог из Санкт-Петербурга',
      hobbies: 'Дождь, редкие растения, чай с мятой',
      description: 'Спокойная, но очень наблюдательная. Всегда замечает то, что скрыто.',
      imageUrl: 'assets/images/Anna.jpg',
    ),
    Character(
      name: 'Кира',
      profession: 'Кибер-агент из 2142 года',
      hobbies: 'Нейросети, неоновые улицы, ретро-код',
      description: 'Говорит на 7 языках, включая Python и шифры. Не боится будущего.',
      imageUrl: 'assets/images/Kira.jpg',
    ),
    Character(
      name: 'София',
      profession: 'Бариста-поэт из Неаполя',
      hobbies: 'Итальянские сонеты, лимонный джин, закаты у моря',
      description: 'Страстная, щедрая, всегда готова удивить. Говорит на метафорах.',
      imageUrl: 'assets/images/Sophia.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: _characters.length,
        itemBuilder: (context, index) {
          final character = _characters[index];
          return Stack(
            children: [
              Image.asset(
                character.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 240,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      character.profession,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Увлечения: ${character.hobbies}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      character.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/chat',
                            arguments: character,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Начать чат',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}