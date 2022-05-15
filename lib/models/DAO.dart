import 'package:firebase_database/firebase_database.dart';

class DAO {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  int count = 0;

  DAO() {}

  Future<void> update() async {
    await ref.update({"count": count});
    count += 1;
  }

  // Future<Object> getValue() async {
  //   final ref = FirebaseDatabase.instance.ref();
  //   final snapshot = await ref.child('/').get();
  //   if (snapshot.exists) {
  //     // const int snapshot.value ;
  //     return (snapshot.value);
  //     // return 1;
  //   } else {
  //     // return -1;
  //     print('No data available.');
  //     // print('No data available.');
  //   }
  // }
}
