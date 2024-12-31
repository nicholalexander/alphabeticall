import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';
import 'word/word_details_view.dart';
import 'word/word.dart';
import 'home_page.dart'; // Home Page
import 'index_page.dart'; // Index Page
import 'letter_page.dart'; // Letter-specific Page

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.settingsController});

  final SettingsController settingsController;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Word> allWords = []; // Global word list

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: widget.settingsController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            switch (routeSettings.name) {
              case SettingsView.routeName:
                return MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      SettingsView(controller: widget.settingsController),
                );
              case WordDetailsView.routeName:
                // Ensure that Word object is passed correctly
                final Word word = routeSettings.arguments as Word;
                return MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      WordDetailsView(word: word), // Pass the Word object
                );
              case '/letter':
                // Extract the letter from route arguments and filter words accordingly
                final String letter = routeSettings.arguments as String;
                final List<Word> filteredWords = allWords
                    .where((word) => word.word.startsWith(letter.toLowerCase()))
                    .toList();
                return MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      LetterPage(letter: letter, words: filteredWords),
                );
              case '/index':
                // Pass the full word list to the IndexPage
                return MaterialPageRoute<void>(
                  builder: (BuildContext context) => IndexPage(words: allWords),
                );
              case '/':
              default:
                // Load the home page and trigger loading of words
                return MaterialPageRoute<void>(
                  builder: (BuildContext context) => HomePage(
                    onWordsLoaded: (List<Word> words) {
                      setState(() {
                        allWords = words;
                      });
                    },
                  ),
                );
            }
          },
        );
      },
    );
  }
}
