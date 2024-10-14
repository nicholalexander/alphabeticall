import 'package:flutter/material.dart';
import 'word/word.dart';
import 'word/word_details_view.dart';

class SearchPage extends StatefulWidget {
  final List<Word> words;

  const SearchPage({super.key, required this.words});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';
  List<Word> filteredWords = [];

  @override
  void initState() {
    super.initState();
    filteredWords = widget.words;
  }

  void updateSearchResults(String searchTerm) {
    setState(() {
      query = searchTerm;
      filteredWords = widget.words
          .where(
              (word) => word.word.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Words'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search for a word',
                border: OutlineInputBorder(),
              ),
              onChanged: updateSearchResults,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredWords.length,
                itemBuilder: (context, index) {
                  final word = filteredWords[index];
                  return ListTile(
                    title: Text(word.word),
                    subtitle: Text(word.meanings.first.def),
                    onTap: () {
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
            ),
          ],
        ),
      ),
    );
  }
}
