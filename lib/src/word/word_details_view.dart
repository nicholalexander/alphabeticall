import 'package:flutter/material.dart';
import 'word.dart';

class WordDetailsView extends StatelessWidget {
  final Word word;

  const WordDetailsView({super.key, required this.word});

  static const routeName = '/words';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(word.word)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              word.word,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: word.meanings.length,
                itemBuilder: (context, index) {
                  final meaning = word.meanings[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ${meaning.def}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            meaning.speechPart,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (meaning.hasMeaning())
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.book,
                                      size: 16,
                                      color: theme.colorScheme.primary),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Example: "${meaning.example}"',
                                      style:
                                          theme.textTheme.bodyLarge?.copyWith(
                                        fontStyle: FontStyle.italic,
                                        color: theme.hintColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 8),
            Text(
              'Wordset ID: ${word.wordsetId}',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
