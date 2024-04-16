import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hm/controllers/persistence/persistence_controller.dart';
import 'package:hm/entities/hm_memory.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';

class FirestoreController implements PersistenceController {
  late FirebaseFirestore db;

  @override
  Future<List<HmMemory>> getAllData() async {
    await init();
    QuerySnapshot snapshot = await db.collection('hmHistory').get();
    List<HmMemory> history = snapshot.docs
        .map(
            (mem)  {
          Map<String, dynamic> data = mem.data() as Map<String, dynamic>;
          return HmMemory.fromMap(data);
        })
        .toList();
    history.sort((a, b) => b.date.compareTo(a.date));
    return history;
  }

  @override
  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    db = FirebaseFirestore.instance;
  }

  @override
  Future<void> saveData(HmMemory hmMemory) async {
    await init();
    await db.collection('hmHistory').add(hmMemory.toMap());
  }
}