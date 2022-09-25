import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../exceptions.dart';
import '../model/cart.dart';
import '../model/order_model.dart';
import '../webservices/order_web_services.dart';

class OrderRepository {
  OrderWebServices orderWebServices;

  OrderRepository(this.orderWebServices);
  Future<List<Order>> getAllOrders(userId) async {
    List<Order> orders = [];
    List<CartItem> items = [];
    List<CartItem> orderitems = [];
    try {
      final loadedOrders = await orderWebServices
          .getAllOrdersFirebaseSDK(userId) as List<QueryDocumentSnapshot>;

      if (loadedOrders == null) {
        return [];
      }

      loadedOrders.forEach((order) {
        Order newOrder = Order.fromJson(order.data() as Map<dynamic, dynamic>);
        orders.add(newOrder);
      });

      return orders;
    } catch (e) {
      print('insideErrorOrderRepo');
      print(e);
      return [];
    }
  }

  Future<dynamic> addOrder(
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
      final response = await orderWebServices.addOrderToFireStore(
        dateTime: dateTime,
        del: del,
        items: items,
        total: total,
        userId: userId,
        firstName: firstName,
        phone: phone,
        totalVat: totalVat,
        totalTax: totalTax,
        ser: ser,
        no: no,
        net: net,
        totalOfferDis: totalOfferDis,
      );

      if (response['name'] != null) {
        return response['name'];
      }
    } on FormatException catch (_) {
      rethrow;
    } on SocketException catch (_) {
      rethrow;
    } on FailedToAddOrderException catch (_) {
      rethrow;
    } on TimeOutException catch (_) {
      rethrow;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<dynamic> removeOrder({userId, orderId}) async {
    final response = await orderWebServices.removeOrder(
      userId: userId,
      orderId: orderId,
    );
    return response;
  }
}
