import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 205, 191, 68)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var btnCounter = 0;
  void incrementBtnCounter() {
    btnCounter++;
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    var btnCounter = appState.btnCounter;

    return Scaffold(
      body: Column(
        children: [
          HintTitle(),
          BigCard(pair: pair),
          // ↓ Add this.
          ElevatedButton(
            onPressed: () {
              // print('button pressed!');
              appState.getNext();
              appState.incrementBtnCounter();
            },
            child: Text('Next, Btn pressed: $btnCounter'),
          ),
        ],
      ),
    );
  }
}

class HintTitle extends StatelessWidget {
  const HintTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // return Text('A random AWESOME idea:');
    return Text(
      'A random AWESOME idea:',
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "{pair.first} {pair.second}",
        ),
      ),
    );
  }
}
