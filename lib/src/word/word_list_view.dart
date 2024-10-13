import 'dart:convert'; // For jsonDecode
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For rootBundle

import '../settings/settings_view.dart';
import 'word.dart';
import 'word_details_view.dart';

class WordListView extends StatefulWidget {
  const WordListView({super.key});

  static const routeName = '/';

  @override
  _WordListViewState createState() => _WordListViewState();
}

class _WordListViewState extends State<WordListView> {
  List<Word> items = [];

  @override
  void initState() {
    super.initState();
    loadWords();
  }

  Future<void> loadWords() async {
    // Load the JSON file from assets
    final String response = await rootBundle.loadString('assets/words/a.json');
    final data = jsonDecode(response) as Map<String, dynamic>;

    // Convert the JSON into a list of Word objects
    List<Word> loadedWords = [];
    data.forEach((key, value) {
      loadedWords.add(Word.fromJson(value));
    });

    // Set the state with the new list of words
    setState(() {
      items = loadedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: items.isEmpty
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator while loading
          : ListView.builder(
              restorationId: 'WordListView',
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];

                return ListTile(
                  title: Text(item.word),
                  leading: const CircleAvatar(
                    foregroundImage:
                        AssetImage('assets/images/flutter_logo.png'),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      WordDetailsView.routeName,
                      arguments: item, // Passing the Word object
                    );
                  },
                );
              },
            ),
    );
  }
}



