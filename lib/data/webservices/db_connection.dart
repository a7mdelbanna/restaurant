import 'package:firebase_database/firebase_database.dart';

class DbConnection {
  DbConnection();
  DatabaseReference dbRef = FirebaseDatabase.instance.ref('items');
  readdata() {
    dbRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
    });
  }
}
