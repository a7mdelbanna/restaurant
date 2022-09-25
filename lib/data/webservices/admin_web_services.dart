import 'package:firebase_database/firebase_database.dart';

import '../exceptions.dart';

class AdminWebServices {
  Future<dynamic> getAllUsersFirebaseSDK() async {
    var data;
    try {
      DatabaseReference itemsRef = FirebaseDatabase.instance.ref('users/');

      DatabaseEvent event = await itemsRef.once();

      //itemsRef.keepSynced(true);

      if (event.snapshot.exists == false) {
        throw DataException('no Data to get');
      } else {
        data = event.snapshot.value;
      }
      print(event);
      print(data);
      return data;
    } on TimeOutException catch (e) {
      print(e);
      return throw TimeOutException('Connection Failed With timeout');
    } on DataException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<dynamic> getAllOrdersFirebaseSDK() async {
    var data;
    try {
      DatabaseReference itemsRef = FirebaseDatabase.instance.ref('Orders/');

      DatabaseEvent event = await itemsRef.once();

      //itemsRef.keepSynced(true);

      if (event.snapshot.exists == false) {
        throw DataException('no Data to get');
      } else {
        data = event.snapshot.value;
      }
      print(event);
      print(data);
      return data;
    } on TimeOutException catch (e) {
      print(e);
      return throw TimeOutException('Connection Failed With timeout');
    } on DataException catch (e) {
      print(e);
      rethrow;
    }
  }
}
