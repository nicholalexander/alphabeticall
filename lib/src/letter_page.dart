import 'package:flutter/material.dart';
import 'word/word.dart';

class LetterPage extends StatelessWidget {
  final String letter;
  final List<Word> words; // The filtered list of words

  const LetterPage({super.key, required this.letter, required this.words});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Words Starting with $letter')),
      body: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          final word = words[index];
          return ListTile(
            title: Text(word.word),
            subtitle: Text(word.meanings.first.def),
          );
        },
      ),
    );
  }
}
