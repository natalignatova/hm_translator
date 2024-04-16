import 'package:hm/entities/hm_memory.dart';

abstract class PersistenceController {
  Future<void> init();
  Future<List<HmMemory>> getAllData();
  Future<void> saveData(HmMemory hmMemory);
}