import 'package:flutter/material.dart';
import 'package:hm/views/translator_screen.dart';
import 'package:hm/controllers/history_controller.dart';
import '../entities/hm_memory.dart';

class HmHistoryView extends StatefulWidget {
  const HmHistoryView({Key? key}) : super(key: key);

  @override
  State<HmHistoryView> createState() => _HmHistoryView();
}

class _HmHistoryView extends State<HmHistoryView> {
  late GetHistoryMethod getHistory;
  List<HmMemory> historyList = [];

  @override
  void initState() {
    super.initState();
    getHistory = GetHistoryMethod();
    loadHistory();
  }

  Future<void> loadHistory() async {
    List<HmMemory> history = await getHistory.getAllHistory();
    setState(() {
      historyList = history;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Saved translations',
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
          icon: Icon(Icons.translate, color: Color(0xFF3434c9)),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => HmMainScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 6),
                historyList.isEmpty
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: historyList.length,
                  itemBuilder: (context, index) {
                    String dateHm = historyList[index].date.toString();
                    String dateSave = dateHm.substring(0, dateHm.length - 10);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0), // Добавляем отступ снизу
                      child: Text(
                        '  ' +
                            dateSave +
                            "\n" +
                            historyList[index].fromLang +
                            " -> " +
                            historyList[index].toLang,
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 16,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
