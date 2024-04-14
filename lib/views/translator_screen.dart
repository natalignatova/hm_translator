import 'package:flutter/material.dart';
import 'package:hm/controllers/translator_controller.dart';
import 'package:hm/models/translator_model.dart';
import 'package:hm/views/history_screen.dart';
import 'package:translator/translator.dart';

class HmMainScreen extends StatefulWidget {
  @override
  _HmMainScreenState createState() => _HmMainScreenState();
}

class _HmMainScreenState extends State<HmMainScreen> {
  late GoogleTranslator translator;
  late TranslationController translationController;

  @override
  void initState() {
    super.initState();
    translator = GoogleTranslator();
    translationController = TranslationController(
      translator: translator,
      setStateCallback: () {
        setState(() {});
      },
    );
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
      body: TranslationView(controller: translationController),
    );
  }
}