import 'package:flutter/material.dart';
import 'letter_page.dart';
import 'word/word.dart';

class IndexPage extends StatelessWidget {
  final List<Word> words; // Receive the list of words from the HomePage

  const IndexPage({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Word Index')),
      body: ListView.builder(
        itemCount: 26, // A to Z
        itemBuilder: (context, index) {
          String letter = String.fromCharCode(65 + index); // 'A' to 'Z'
          List<Word> filteredWords = words
              .where((word) => word.word.startsWith(letter.toLowerCase()))
              .toList();

          return ListTile(
            title: Text(letter, style: const TextStyle(fontSize: 24)),
            onTap: () {
              // Pass the filtered words for the selected letter
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LetterPage(letter: letter, words: filteredWords),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
