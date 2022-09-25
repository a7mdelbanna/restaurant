import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';

// import 'package:http/http.dart';
import '../const.dart';
import '../exceptions.dart';
import '../model/meal.dart';

class MealsWebServices {
  late Dio dio;
  List<Meal> meals = [];
  MealsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 60 seconds,
      receiveTimeout: 20 * 1000,
    );

    dio = Dio(options);
  }

  Future<dynamic> getAllItems() async {
    try {
      Response response = await dio.get('Items.json');

      return response.data;
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  Future<dynamic> getAllItemsFirebaseSDK() async {
    var data;
    try {
      DatabaseReference itemsRef = FirebaseDatabase.instance.ref('Items/');

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

  Future uploadItemImage(itemId, itemName, imageUrl) async {
    DatabaseReference itemsRef =
        FirebaseDatabase.instance.ref('Items/$itemId/$itemName');
    await itemsRef.update({
      'ItemImageUrl': imageUrl,
    }).then((value) {
      return true;
    }).catchError((e) {
      return false;
    });
  }

  Future uploadItemInfo(itemId, itemName, itemDescription, itemIngredients,
      itemNuetrations) async {
    DatabaseReference itemsRef =
        FirebaseDatabase.instance.ref('Items/$itemId/$itemName');
    await itemsRef.update({
      'ItemDescription': itemDescription,
      'ItemIngredients': itemIngredients,
      'ItemNuetrations': itemNuetrations,
    }).then((value) {
      return true;
    }).catchError((e) {
      return false;
    });
  }
}
