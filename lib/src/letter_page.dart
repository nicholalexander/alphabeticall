import 'package:flutter/material.dart';
import 'word/word.dart';
import 'word/word_details_view.dart'; // Import WordDetailsView

class LetterPage extends StatelessWidget {
  final String letter;
  final List<Word> words; // The filtered list of words

  const LetterPage({super.key, required this.letter, required this.words});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$letter words')),
      body: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          final word = words[index];
          return ListTile(
            title: Text(word.word),
            subtitle: Text(word.meanings.first.def),
            onTap: () {
              // Navigate to WordDetailsView and pass the selected word
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
