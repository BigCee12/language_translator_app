import 'package:flutter/material.dart';
import 'package:translation_app/translation.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // remove debug banner
      title: 'Language Translator',
      home: TranslationScreen(title: 'Language Translator'),
    );
  }
}


