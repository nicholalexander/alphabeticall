class Meaning {
  final String id;
  final String def;
  final String example;
  final String speechPart;

  Meaning({
    required this.id,
    required this.def,
    required this.example,
    required this.speechPart,
  });

  factory Meaning.fromJson(Map<String, dynamic> json) {
    return Meaning(
      id: json['id'] as String? ?? '', // Default to an empty string if null
      def: json['def'] as String? ?? 'No definition available',
      example: json['example'] as String? ?? 'No example available',
      speechPart: json['speech_part'] as String? ?? 'Unknown',
    );
  }

  bool hasMeaning() {
    return example.isNotEmpty && example != 'No example available';
  }
}


class Word {
  final String word;
  final String wordsetId;
  final List<Meaning> meanings;

  Word({
    required this.word,
    required this.wordsetId,
    required this.meanings,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    var meaningsJson = json['meanings'] as List? ?? [];
    List<Meaning> meaningsList =
        meaningsJson.map((i) => Meaning.fromJson(i)).toList();

    return Word(
      word: json['word'] as String? ?? 'Unknown word',
      wordsetId: json['wordset_id'] as String? ?? 'Unknown',
      meanings: meaningsList,
    );
  }
}
