import 'package:flutter/material.dart';
import 'word.dart';

/// Displays detailed information about a Word.
class WordDetailsView extends StatelessWidget {
  const WordDetailsView({super.key});

  static const routeName = '/words';

  @override
  Widget build(BuildContext context) {
    // Retrieve the Word object directly from the arguments
    final Word word = ModalRoute.of(context)!.settings.arguments as Word;

    return Scaffold(
      appBar: AppBar(
        title: Text(word.word),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Word title
                Text(
                  word.word,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Wordset ID
                Text(
                  'Wordset ID: ${word.wordsetId}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),

                // Meanings with dividers
                Expanded(
                  child: ListView.separated(
                    itemCount: word.meanings.length,
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    itemBuilder: (context, index) {
                      final meaning = word.meanings[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Part of speech as a Chip
                            Row(
                              children: [
                                const Text(
                                  'Part of Speech: ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Chip(
                                  label: Text(
                                    meaning.speechPart,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.blueAccent,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Definition
                            Text(
                              meaning.def,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Example sentence
                            Text(
                              'Example: "${meaning.example}"',
                              style: const TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
