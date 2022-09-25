import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import '../const.dart';
import '../exceptions.dart';
// import 'package:http/http.dart';
// import '../const_model.dart';
import '../model/order_model.dart';

class OrderWebServices {
  late Dio dio;
  final dbRef = FirebaseFirestore.instance;
  OrderWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 60 * 1000, // 60 seconds,
      receiveTimeout: 60 * 1000,
    );

    dio = Dio(options);
  }

  Future<dynamic> getAllOrdersFirebaseSDK(userId) async {
    QuerySnapshot data;
    try {
      print(userId);
      data = await dbRef
          .collection('Orders')
          .where('userId', isEqualTo: userId)
          .get();
      return data.docs;
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  Future<dynamic> addOrderToFireStore(
      {del,
      total,
      items,
      userId,
      firstName,
      dateTime,
      phone,
      net,
      totalTax,
      totalVat,
      totalOfferDis,
      ser,
      no}) async {
    try {
      print('insideAddtoFireStore');
      DocumentReference response = await dbRef.collection('Orders').add(
            orderToJson(
              firstName: firstName,
              phone: phone,
              total: total,
              del: del,
              dateTime: dateTime,
              items: items,
              userId: userId,
              net: net,
              no: no,
              ser: ser,
              totalTax: totalTax,
              totalOfferDis: totalOfferDis,
            ),
          );
      if (response == null || response.id == null) {
        throw FailedToAddOrderException('Can\'t Connect to the server');
      }

      return response;
    } on FailedToAddOrderException catch (_) {
      rethrow;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<dynamic> removeOrder({orderId, userId}) async {
    try {
      Response response = await dio.delete(
        'https://wholesaletest2-b80fc-default-rtdb.firebaseio.com/Orders/$userId/$orderId.json',
      );
      print(response.statusCode);

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
