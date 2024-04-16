import 'package:flutter/material.dart';
import 'package:hm/controllers/search_controller.dart';
import 'package:translator/translator.dart';

import 'history_controller.dart';

class TranslationController {
  final TextEditingController textEditingController = TextEditingController();
  String translatedText = '';
  final List<String> languages = ['Russian', 'English', 'Eesti'];
  String selectedLanguageFrom = 'Russian';
  String selectedLanguageTo = 'Eesti';
  final GoogleTranslator translator;
  final Function? setStateCallback;

  late SearchYT searchYT;

  TranslationController({required this.translator, this.setStateCallback}) {
    searchYT = SearchYT(searchQuery: 'EEK Mainor');
  }

  void updateSelectedLanguageFrom(String newValue) {
    selectedLanguageFrom = newValue;
  }

  void updateSelectedLanguageTo(String newValue) {
    selectedLanguageTo = newValue;
  }

  void translateText() async {
    String inputText = textEditingController.text;
    if (inputText.isNotEmpty) {
      String sourceLanguageCode;
      String targetLanguageCode;

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

      searchYT.searchQuery = translatedText;

      setStateCallback!();

    }
  }
}
