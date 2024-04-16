import 'package:flutter/material.dart';
import 'package:hm/controllers/persistence/firestore_controller.dart';
import 'dart:core';
import 'package:hm/controllers/persistence/persistence_controller.dart';
import '../entities/hm_memory.dart';


class AddHistoryMethod extends ChangeNotifier{
  PersistenceController persistenceController = FirestoreController();
  Future<void> addItemHistory(HmMemory historyItem) async {
    await persistenceController.saveData(historyItem);
    notifyListeners();
  }
  VoidCallback updateStateCallback;
  AddHistoryMethod({
    required this.updateStateCallback,
  });
  void setUpdateStateCallback(VoidCallback callback) {
    updateStateCallback = callback;
  }
}

class GetHistoryMethod {
  List<HmMemory> historyList = [];
  PersistenceController persistenceController = FirestoreController();
  Future<List<HmMemory>> getAllHistory() async {
    return persistenceController.getAllData();
  }
}