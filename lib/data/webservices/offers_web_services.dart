import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';

// import 'package:http/http.dart';
import '../const.dart';

class OffersWebServices {
  late Dio dio;

  OffersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 60 seconds,
      receiveTimeout: 20 * 1000,
    );

    dio = Dio(options);
  }

  // Future<dynamic> getAllItems() async {
  //   try {
  //     Response response = await dio.get('Items.json');
  //
  //     return response.data;
  //   } catch (e) {
  //     print(e.toString());
  //     return e;
  //   }
  // }

  Future<dynamic> getAllOffersFirebaseSDK() async {
    var data;
    try {
      DatabaseReference offersRef = FirebaseDatabase.instance.ref('Offers');
      DatabaseEvent event = await offersRef.once();
      // offersRef.keepSynced(true);
      data = event.snapshot.value;
//     print(data);
//     });
// Stream<DatabaseEvent> stream = itemsRef.onValue;
// stream.listen((DatabaseEvent event) {
//   print('Event Type: ${event.type}');
// DatabaseEventType.value;
//   print('Snapshot: ${event.snapshot.value}');
      // });

      return data;
    } catch (e) {
      // itemsRef.onValue.listen((DatabaseEvent event) {
      //
      // print('items');
      // print(data);
      // });
      return e;
      // print(e.toString());
      // return e;
    }
  }
}
