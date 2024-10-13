import 'package:flutter/material.dart';

/// Displays detailed information about a Word.
class WordDetailsView extends StatelessWidget {
  const WordDetailsView({super.key});

  static const routeName = '/words';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Details'),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
