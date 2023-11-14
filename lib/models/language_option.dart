


class LanguageOption {
  final String code;
  final String name;

  LanguageOption({required this.code, required this.name});


 static List<LanguageOption> _availableLanguages = [
    LanguageOption(code: 'en', name: 'English'),
    LanguageOption(code: 'es', name: 'Spanish'),
    LanguageOption(code: 'fr', name: 'French'),
    LanguageOption(code: 'de', name: 'German'),
    LanguageOption(code: 'it', name: 'Italian'),
    LanguageOption(code: 'pt', name: 'Portuguese'),
    LanguageOption(code: 'ru', name: 'Russian'),
    LanguageOption(code: 'zh', name: 'Chinese'),
    LanguageOption(code: 'ja', name: 'Japanese'),
    LanguageOption(code: 'ko', name: 'Korean'),
    LanguageOption(code: 'ar', name: 'Arabic'),
    LanguageOption(code: 'hi', name: 'Hindi'),
    LanguageOption(code: 'tr', name: 'Turkish'),
    LanguageOption(code: 'nl', name: 'Dutch'),
    LanguageOption(code: 'sv', name: 'Swedish'),
    LanguageOption(code: 'fi', name: 'Finnish'),
    LanguageOption(code: 'pl', name: 'Polish'),
    LanguageOption(code: 'cs', name: 'Czech'),
    LanguageOption(code: 'el', name: 'Greek'),
    LanguageOption(code: 'he', name: 'Hebrew'),
    LanguageOption(code: 'th', name: 'Thai'),
    LanguageOption(code: 'id', name: 'Indonesian'),
    LanguageOption(code: 'vi', name: 'Vietnamese'),
    LanguageOption(code: 'ro', name: 'Romanian'),
    LanguageOption(code: 'da', name: 'Danish'),
    LanguageOption(code: 'no', name: 'Norwegian'),
    LanguageOption(code: 'hu', name: 'Hungarian'),
    LanguageOption(code: 'bg', name: 'Bulgarian'),
    LanguageOption(code: 'uk', name: 'Ukrainian'),
    LanguageOption(code: 'hr', name: 'Croatian'),
  ];

  static List<LanguageOption> get availableLanguages => _availableLanguages;
}


  // Add you