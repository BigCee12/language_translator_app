import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translation_app/models/language_option.dart';
import 'package:clipboard/clipboard.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  TranslationScreenState createState() => TranslationScreenState();
}

class TranslationScreenState extends State<TranslationScreen> {
  final translator = GoogleTranslator();
  TextEditingController inputController = TextEditingController();
  String _outputText = 'Translation will appear here.';
  LanguageOption? _sourceLanguage;
  LanguageOption? _targetLanguage;
  final FlutterTts flutterTts = FlutterTts();

  void _copyToClipboard() {
    FlutterClipboard.copy(_outputText)
        .then((value) => _showSnackbar('Copied to clipboard'));
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
  Future<void> _translate() async {
    String inputText = inputController.text;
    try {
      var translation = await translator.translate(
        inputText,
        from: _sourceLanguage?.code ?? 'en',
        to: _targetLanguage?.code ?? 'en',
      );
      String translatedText = translation.text;
      setState(() {
        _outputText = translatedText;
      });
    } catch (e) {
      print("Translation error: $e");
    }
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage(_sourceLanguage?.code ?? 'en');
    await flutterTts.speak(text);
  }

  Future<void> _speakTranslatedText() async {
    await flutterTts.setLanguage(_targetLanguage?.code ?? 'en');
    await flutterTts.speak(_outputText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 0, 52, 94),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<LanguageOption>(
                    value: _sourceLanguage ??
                        LanguageOption.availableLanguages.first,
                    items: LanguageOption.availableLanguages
                        .map((LanguageOption option) {
                      return DropdownMenuItem<LanguageOption>(
                        value: option,
                        child: Text(option.name),
                      );
                    }).toList(),
                    onChanged: (LanguageOption? value) {
                      setState(() {
                        _sourceLanguage = value;
                      });
                    },
                  ),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.swap_horiz,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 16),
                  DropdownButton<LanguageOption>(
                    borderRadius: BorderRadius.circular(12),
                    value: _targetLanguage ??
                        LanguageOption.availableLanguages.first,
                    items: LanguageOption.availableLanguages
                        .map((LanguageOption option) {
                      return DropdownMenuItem<LanguageOption>(
                        value: option,
                        child: Text(
                          option.name,
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (LanguageOption? value) {
                      setState(() {
                        _targetLanguage = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              height: 200,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                _sourceLanguage?.name ?? 'Source Language',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 0, 52, 94),
                                ),
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                onPressed: () {
                                  _speak(inputController.text);
                                },
                                icon: const Icon(
                                  Icons.volume_up,
                                  color: Color.fromARGB(255, 0, 52, 94),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          elevation: 0,
                          child: TextField(
                            maxLines: null,
                            controller: inputController,
                            decoration: InputDecoration(
                              labelText: 'Enter Text',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.grey[700],
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, bottom: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 52, 94),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () {
                              _translate();
                            },
                            child: const Text(
                              'Translate',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          _targetLanguage?.name ?? 'Target Language',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 0, 52, 94),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            _speakTranslatedText();
                          },
                          icon: const Icon(
                            Icons.volume_up,
                            color: Color.fromARGB(255, 0, 52, 94),
                          ),
                        ),
                         const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _copyToClipboard();
                          },
                          child: const Icon(size: 20,
                            Icons.copy,
                            color: Color.fromARGB(255, 0, 52, 94),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _outputText,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  
}
