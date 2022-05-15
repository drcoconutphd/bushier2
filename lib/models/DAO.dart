import 'package:firebase_database/firebase_database.dart';

class DAO {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  int count = 0;

  DAO() {

  }

  Future<void> update() async {
    await ref.update({
      "count": count
    });
    count += 1;
  }
}
