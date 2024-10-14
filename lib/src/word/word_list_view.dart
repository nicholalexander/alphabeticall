import 'package:flutter/material.dart';
import 'word.dart';
import 'word_details_view.dart';

class LetterPage extends StatelessWidget {
  final String letter;
  final List<Word> words; // Filtered words for this letter

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
            onTap: () {
              // Navigate to the details page and pass the word object
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WordDetailsView(word: word),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
