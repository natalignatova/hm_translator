import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:hm/screens/hm_history.dart';

class HmMainScreen extends StatefulWidget {
  @override
  _HmMainScreenState createState() => _HmMainScreenState();
}

class _HmMainScreenState extends State<HmMainScreen> {
  final translator = GoogleTranslator();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TranslationPage(translator: translator),
    );
  }
}

class TranslationPage extends StatefulWidget {
  final GoogleTranslator translator;

  TranslationPage({required this.translator});

  @override
  _TranslationPageState createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  TextEditingController _textEditingController = TextEditingController();
  String _translatedText = '';
  final List<String> languages = ['Russian', 'English', 'Eesti']; // Список языков
  String selectedLanguageFrom = 'English'; // Выбранный язык "из"
  String selectedLanguageTo = 'Russian'; // Выбранный язык "в"

  void _translateText() async {
    String inputText = _textEditingController.text;
    String sourceLanguageCode;
    String targetLanguageCode;

    // Определите код выбранного языка "из"
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
        sourceLanguageCode = 'en'; // По умолчанию используется английский
    }

    // Определите код выбранного языка "в"
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
        targetLanguageCode = 'ru'; // По умолчанию используется русский
    }

    Translation translation = await widget.translator.translate(
      inputText,
      from: sourceLanguageCode,
      to: targetLanguageCode,
    );
    setState(() {
      _translatedText = translation.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'H m ?',
          style: TextStyle(
            color: Color(0xFF3434c9),
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Outfit',
          ),
        ),
        backgroundColor: Color(0xFFf7f7f7),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.history, color: Color(0xFF3434c9)),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => HmHistory()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                  value: selectedLanguageFrom, // Выбранный язык "из"
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLanguageFrom = newValue!;
                    });
                  },
                  items: languages.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Icon(Icons.arrow_forward),
                DropdownButton<String>(
                  value: selectedLanguageTo, // Выбранный язык "в"
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLanguageTo = newValue!;
                    });
                  },
                  items: languages.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Put your text...',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _translateText,
              child: Text('Translate'),
            ),
            SizedBox(height: 20),
            Text(
              'Translated Text:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(_translatedText),
          ],
        ),
      ),
    );
  }
}
