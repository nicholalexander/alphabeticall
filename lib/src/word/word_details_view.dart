import 'package:flutter/material.dart';
import 'word.dart';

class WordDetailsView extends StatelessWidget {
  final Word word; // Word object passed from the list

  const WordDetailsView({super.key, required this.word});

  static const routeName = '/words'; // Add routeName here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(word.word)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              word.word,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
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
                        Text(
                          '${index + 1}. ${meaning.def}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Part of Speech: ${meaning.speechPart}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
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
            const Divider(thickness: 1),
            const SizedBox(height: 8),
            Text(
              'Wordset ID: ${word.wordsetId}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
