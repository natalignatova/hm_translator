
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
  final List<String> languages = ['Russian', 'English', 'Eesti'];
  String selectedLanguageFrom = 'English';
  String selectedLanguageTo = 'Russian';

  void _translateText() async {
    String inputText = _textEditingController.text;
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
        backgroundColor: Color(0xFFb9b9c7),
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFb9b9c7),
              Color(0xFF3434c9),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<String>(
                    value: selectedLanguageFrom,
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
                    value: selectedLanguageTo,
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
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFcacad9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: 'Put your text...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FloatingActionButton(
                              backgroundColor: const Color(0xff3434c9),
                              foregroundColor: Colors.grey[200],
                              onPressed: _translateText,
                              child: Icon(Icons.arrow_forward),
                              shape: CircleBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffb5b5e8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        _translatedText,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}