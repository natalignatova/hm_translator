import 'package:flutter/material.dart';
import 'package:hm/controllers/translator_controller.dart';

class TranslationView extends StatefulWidget {
  final TranslationController controller;

  const TranslationView({Key? key, required this.controller}) : super(key: key);

  @override
  _TranslationViewState createState() => _TranslationViewState();
}

class _TranslationViewState extends State<TranslationView> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                  value: widget.controller.selectedLanguageFrom,
                  onChanged: (String? newValue) {
                    setState(() {
                      widget.controller.updateSelectedLanguageFrom(newValue!);
                    });
                  },
                  items: widget.controller.languages.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Icon(Icons.arrow_forward),
                DropdownButton<String>(
                  value: widget.controller.selectedLanguageTo,
                  onChanged: (String? newValue) {
                    setState(() {
                      widget.controller.updateSelectedLanguageTo(newValue!);
                    });
                  },
                  items: widget.controller.languages.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 8),
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
                      controller: widget.controller.textEditingController,
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
                            onPressed: () {
                              setState(() {
                                widget.controller.translateText();
                              });
                            },
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
            SizedBox(height: 8),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffc7c7ff),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.controller.translatedText,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffa6a6e3),
                  borderRadius: BorderRadius.circular(10),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}