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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Word section at the top
            Text(
              word.word,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            const SizedBox(height: 16),

            // Meanings and examples
            Expanded(
              child: ListView.builder(
                itemCount: word.meanings.length,
                itemBuilder: (context, index) {
                  final meaning = word.meanings[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Definition
                        Text(
                          '${index + 1}. ${meaning.def}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Part of speech as plain text
                        Text(
                          'Part of Speech: ${meaning.speechPart}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Example sentence, if available
                        if (meaning.example.isNotEmpty)
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

            // Meta section at the bottom
            const Divider(thickness: 1),
            const SizedBox(height: 8),
            Text(
              'Metadata',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              'Wordset ID: ${word.wordsetId}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
