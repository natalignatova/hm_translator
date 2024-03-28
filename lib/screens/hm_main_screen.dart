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

  void _translateText() async {
    String inputText = _textEditingController.text;
    Translation translation =
    await widget.translator.translate(inputText, to: 'ru');
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
                MaterialPageRoute(builder: (context) => HmHistory()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Enter text to translate...',
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
