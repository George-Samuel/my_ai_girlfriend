import 'package:flutter/material.dart';

// ЕДИНСТВЕННОЕ определение Character в проекте
class Character {
  final String name;
  final String profession;
  final String hobbies;
  final String description;
  final String imageUrl;

  const Character({
    required this.name,
    required this.profession,
    required this.hobbies,
    required this.description,
    required this.imageUrl,
  });
}

// Глобальный список персонажей (вне класса!)
final List<Character> _characters = [
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
    imageUrl: 'assets/images/Sofia.jpg',
  ),
];

class CharacterSelectionScreen extends StatelessWidget {
  static const String routeName = '/character-selection';

  const CharacterSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выбери свою девушку'),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Кто будет рядом с тобой?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _characters.length,
                itemBuilder: (context, index) {
                  final character = _characters[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          character.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.person, size: 60),
                        ),
                      ),
                      title: Text(
                        character.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(character.profession),
                          Text('Увлечения: ${character.hobbies}'),
                          const SizedBox(height: 4),
                          Text(
                            character.description,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/chat',
                          arguments: character,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}