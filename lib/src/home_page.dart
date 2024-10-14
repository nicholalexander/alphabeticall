import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'word/word.dart';
import 'index_page.dart';
import 'search_page.dart';
import 'word/word_details_view.dart';

class HomePage extends StatefulWidget {
  final void Function(List<Word> words) onWordsLoaded;

  const HomePage({super.key, required this.onWordsLoaded});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Word> allWords = [];
  Word? randomWord;
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
      randomWord = getRandomWord(loadedWords);
      isLoading = false;
    });

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

  Word getRandomWord(List<Word> words) {
    final random = Random();
    return words[random.nextInt(words.length)];
  }

  void refreshRandomWord() {
    setState(() {
      randomWord = getRandomWord(allWords);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alphabeticall')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              // Wrap the Column in SingleChildScrollView
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Browse Words Card
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IndexPage(words: allWords),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Browse Words',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text('Tap to browse the words'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Search Words Card
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchPage(words: allWords),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Search Words',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text('Tap to search for a word'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Random Word Card
                    GestureDetector(
                      onTap: refreshRandomWord,
                      child: SizedBox(
                        width: double.infinity,
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Random Word',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                if (randomWord != null)
                                  Text(
                                    '${randomWord!.word} (${randomWord!.meanings.first.speechPart})\n${randomWord!.meanings.first.def}',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Tap to get a new word',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}