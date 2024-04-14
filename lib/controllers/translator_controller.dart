import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class TranslationController {
  final TextEditingController textEditingController = TextEditingController();
  String translatedText = '';
  final List<String> languages = ['Russian', 'English', 'Eesti'];
  String selectedLanguageFrom = 'English';
  String selectedLanguageTo = 'Russian';
  final GoogleTranslator translator;

  final Function? setStateCallback;

  TranslationController({required this.translator, this.setStateCallback});

  void updateSelectedLanguageFrom(String newValue) {
    selectedLanguageFrom = newValue;
  }

  void updateSelectedLanguageTo(String newValue) {
    selectedLanguageTo = newValue;
  }

  void translateText() async {
    String inputText = textEditingController.text;
    String sourceLanguageCode;
    String targetLanguageCode;

    //  "из"
    switch (selectedLanguageFrom) {
      case 'Russian':
        sourceLanguageCode = 'ru';
        break;
      case 'English':
        sourceLanguageCode = 'en';
        break;
      case 'Eesti':
        sourceLanguageCode = 'et';
        break;
      default:
        sourceLanguageCode = 'en';
    }

    //  "в"
    switch (selectedLanguageTo) {
      case 'Russian':
        targetLanguageCode = 'ru';
        break;
      case 'English':
        targetLanguageCode = 'en';
        break;
      case 'Eesti':
        targetLanguageCode = 'et';
        break;
      default:
        targetLanguageCode = 'ru';
    }

    Translation translation = await translator.translate(
      inputText,
      from: sourceLanguageCode,
      to: targetLanguageCode,
    );
    translatedText = translation.text;

    if (setStateCallback != null) {
      setStateCallback!();
    }
  }
}
