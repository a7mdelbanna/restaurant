import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';

import '../const.dart';

class CategoriesWebServices {
  late Dio dio;

  SettingsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 60 seconds,
      receiveTimeout: 20 * 1000,
    );

    dio = Dio(options);
  }

  Future<dynamic> getAllCategoriesFirebaseSDK() async {
    var data;
    try {
      DatabaseReference categoriesRef =
          FirebaseDatabase.instance.ref('ItemCategory');
      //
      // //categoriesRef.keepSynced(true);
      // DatabaseEvent event = await categoriesRef.once();
      // data = event.snapshot.value;
      // DatabaseReference itemsRef = FirebaseDatabase.instance.ref('Items/');

      DatabaseEvent event = await categoriesRef.once();
      //categoriesRef.keepSynced(true);
      data = event.snapshot.value;

//Subscribe to the stream!

      // Stream<DatabaseEvent> stream = itemsRef.onValue;
      // stream.listen((DatabaseEvent event) {
      //   print('Event Type: ${event.type}'); // DatabaseEventType.value;
      //   print('Snapshot: ${event.snapshot.value}');
      // });
      // print(data);
      return data;
    } catch (e) {
      return (e);
    }
  }
}
