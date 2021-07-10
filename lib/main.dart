import 'package:flutter/material.dart';
import 'package:job_seeker/widgets/random_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Startup Name Generator',
        home: RandomWords(),
    );
  }
}

