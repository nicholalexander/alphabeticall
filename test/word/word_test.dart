import 'package:flutter_test/flutter_test.dart';
import 'package:alphabeticall/src/word/word.dart';

void main() {
  group('Meaning', () {
    test('should correctly parse from JSON', () {
      final json = {
        'id': '123',
        'def': 'A sample definition',
        'example': 'This is an example.',
        'speech_part': 'noun',
      };

      final meaning = Meaning.fromJson(json);

      expect(meaning.id, '123');
      expect(meaning.def, 'A sample definition');
      expect(meaning.example, 'This is an example.');
      expect(meaning.speechPart, 'noun');
    });

    test('should return true for hasMeaning when example is valid', () {
      final meaning = Meaning(
        id: '123',
        def: 'A sample definition',
        example: 'This is an example.',
        speechPart: 'noun',
      );

      expect(meaning.hasMeaning(), true);
    });

    test('should return false for hasMeaning when example is not valid', () {
      final meaning = Meaning(
        id: '123',
        def: 'A sample definition',
        example: 'No example available',
        speechPart: 'noun',
      );

      expect(meaning.hasMeaning(), false);
    });
  });

  group('Word', () {
    test('should correctly parse from JSON', () {
      final json = {
        'word': 'apophenia',
        'wordset_id': '6871117da0',
        'meanings': [
          {
            'id': 'ef4d0871f7',
            'def':
                'perceiving a pattern or meaning from a stimulus where it does not actually exist',
            'example': 'A common apophenia is seeing a face on the moon.',
            'speech_part': 'noun',
          }
        ],
      };

      final word = Word.fromJson(json);

      expect(word.word, 'apophenia');
      expect(word.wordsetId, '6871117da0');
      expect(word.meanings.length, 1);
      expect(word.meanings.first.def,
          'perceiving a pattern or meaning from a stimulus where it does not actually exist');
    });
  });
}
