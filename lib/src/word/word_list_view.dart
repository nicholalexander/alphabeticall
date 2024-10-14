import 'package:flutter/material.dart';
import 'word.dart';
import 'word_details_view.dart';
import 'dart:convert'; // For jsonDecode
import 'package:flutter/services.dart'; // For rootBundle

class WordListView extends StatefulWidget {
  final String? letter; // New parameter to filter by letter

  const WordListView({super.key, this.letter});

  static const routeName = '/';

  @override
  _WordListViewState createState() => _WordListViewState();
}

class _WordListViewState extends State<WordListView> {
  List<Word> items = [];
  bool isLoading = true; // To track loading state

  @override
  void initState() {
    super.initState();
    loadWords(); // Call the JSON load function in initState
  }

  Future<void> loadWords() async {
    // Load all words or filter by the selected letter
    List<Word> loadedWords = await loadAllWords();

    if (widget.letter != null) {
      loadedWords = loadedWords
          .where((word) => word.word.startsWith(widget.letter!))
          .toList();
    }

    // Update the state after loading words
    setState(() {
      items = loadedWords;
      isLoading = false; // Set loading to false once data is loaded
    });
  }

  Future<List<Word>> loadAllWords() async {
    List<Word> allWords = [];

    // List of all the letters for which we have JSON files
    const letters = 'abcdefghijklmnopqrstuvwxyz';

    try {
      // Loop through each letter and load its corresponding JSON file
      for (var letter in letters.split('')) {
        final String filePath = 'assets/words/$letter.json';
        final String response = await rootBundle.loadString(filePath);
        final data = jsonDecode(response) as Map<String, dynamic>;

        // Convert each word in the JSON file to a Word object and add it to the list
        data.forEach((key, value) {
          allWords.add(Word.fromJson(value));
        });
      }

      return allWords;
    } catch (e) {
      // Handle error (e.g., file not found or failed to load)
      print('Error loading words: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word List'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Show loading indicator
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];

                return ListTile(
                  title: Text(item.word),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      WordDetailsView.routeName,
                      arguments: item, // Pass the Word object
                    );
                  },
                );
              },
            ),
    );
  }
}
