import 'package:flutter/material.dart';
import 'package:hm/controllers/history_controller.dart';
import 'package:hm/controllers/translator_controller.dart';
import 'package:hm/entities/hm_memory.dart';
import 'package:hm/widgets/youtube_widget.dart';
import '../controllers/search_controller.dart';
import '../functions/get_random_int_function.dart';

class TranslationView extends StatefulWidget {
  final TranslationController controller;

  const TranslationView({Key? key, required this.controller}) : super(key: key);

  @override
  _TranslationViewState createState() => _TranslationViewState();
}

class _TranslationViewState extends State<TranslationView> {
  final searchYT = SearchYT(searchQuery: 'tere tulemast EEK Mainor');

  late AddHistoryMethod addHistory;
  late GetHistoryMethod getHistory;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    addHistory = AddHistoryMethod(updateStateCallback: () => setState(() {}));
    getHistory = GetHistoryMethod();
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Dispose the focus node when it is no longer needed
    super.dispose();
  }

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
                      focusNode: _focusNode,
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
                          padding: const EdgeInsets.all(16.0),
                          child: FloatingActionButton(
                            backgroundColor: const Color(0xff3434c9),
                            foregroundColor: Colors.grey[200],
                            onPressed: () {
                              _focusNode.unfocus(); // Hide the keyboard
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
                  color: Color(0xFFc7c7ff),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.controller.translatedText,
                            style: TextStyle(fontSize: 16),
                          ),
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
                                  HmMemory hmHistory = HmMemory(
                                    DateTime.now().subtract(Duration(milliseconds: DateTime.now().millisecond)),
                                    widget.controller.textEditingController.text,
                                    widget.controller.translatedText,
                                  );
                                  addHistory.addItemHistory(hmHistory);
                                });
                              },
                              child: Icon(Icons.save_outlined),
                              shape: CircleBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: FutureBuilder<List<String>>(
                future: searchYT.fetchVideoIds(widget.controller.translatedText), // Pass the translatedText
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    List<String>? videoIds = snapshot.data;
                    int randomInt = getRandomIndex(videoIds);
                    if (videoIds != null && videoIds.isNotEmpty && videoIds[0] != null) {
                      return Container(
                        width: double.infinity,
                        child: ShowMustGoOnWidget(videoId: videoIds[randomInt]),
                      );
                    } else {
                      return Center(
                        child: Text('No videos found'),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}