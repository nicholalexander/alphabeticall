import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'word/word.dart';
import 'index_page.dart';

class HomePage extends StatefulWidget {
  final void Function(List<Word> words) onWordsLoaded;

  const HomePage({super.key, required this.onWordsLoaded});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Word> allWords = [];
  Word? wordOfTheDay;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadWords();
  }

  Future<void> loadWords() async {
    List<Word> loadedWords = await loadAllWords();

    setState(() {
      allWords = loadedWords;
      wordOfTheDay = getRandomWordOfTheDay(loadedWords);
      isLoading = false;
    });

    // Pass the loaded words back to MyApp via the callback
    widget.onWordsLoaded(loadedWords);
  }

  Future<List<Word>> loadAllWords() async {
    List<Word> allWords = [];
    const letters = 'abcdefghijklmnopqrstuvwxyz';

    try {
      for (var letter in letters.split('')) {
        final String filePath = 'assets/words/$letter.json';
        final String response = await rootBundle.loadString(filePath);
        final data = jsonDecode(response) as Map<String, dynamic>;

        data.forEach((key, value) {
          allWords.add(Word.fromJson(value));
        });
      }

      return allWords;
    } catch (e) {
      print('Error loading words: $e');
      return [];
    }
  }

  Word getRandomWordOfTheDay(List<Word> words) {
    final random = Random();
    return words[random.nextInt(words.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alphabeticall')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome to Alphabeticall!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Random Word',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  if (wordOfTheDay != null)
                    Text(
                      '${wordOfTheDay!.word} (${wordOfTheDay!.meanings.first.speechPart})\n${wordOfTheDay!.meanings.first.def}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  const Spacer(),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/index');
                      },
                      child: const Text('Browse Words'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
