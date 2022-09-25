import 'cart.dart';

class Order {
  late final String id;
  late bool del;
  late int state;
  late final double total;
  late final double totalTax;
  late final double totalOfferDis;
  late final List<CartItem> itemsList;
  late final DateTime dateTime;
  late final phone;
  late final double net;
  late final String delAddress;
  late final double ser;
  late final double no;
  late final String userId;
  late final String firstName;
  // late final String customerName;
  Order({
    required this.firstName,
    required this.userId,
    required this.state,
    required this.del,
    required this.id,
    required this.total,
    required this.itemsList,
    required this.dateTime,
    required this.phone,
    required this.net,
    required this.totalTax,
    // required this.totalVat,
    required this.totalOfferDis,
    required this.ser,
    required this.no,
    required this.delAddress,
  });

  Order.fromJson(Map<dynamic, dynamic> json) {
    state = json['state'];
    id = json['orderId'];
    firstName = json['firstName'];
    delAddress = json['delAddress'];
    del = json['del'];
    total = json['totalPrice'] + 0.0;
    dateTime = DateTime.parse(json['dateTime']);
    phone = json['phone'];
    ser = json['ser'] + 0.0;
    no = json['no'] + 0.0;
    totalOfferDis = json['totalOfferDis'] + 0.0;
    net = json['net'] + 0.0;
    userId = json['userId'];
    itemsList =
        List<CartItem>.from(json["items"].map((x) => CartItem.fromJson(x)))
            .toList();
    totalTax = json['totalTax'] + 0.0;
  }
}

Map<String, dynamic> orderToJson(
    {del,
    total,
    items,
    userId,
    dateTime,
    phone,
    net,
    totalTax,
    totalOfferDis,
    delAddress,
    ser,
    firstName,
    orderId,
    state,
    no}) {
  return {
    'delAddress': delAddress,
    'orderId': orderId,
    'phone': phone,
    'del': del,
    'state': state,
    'net': net,
    'totalTax': totalTax,
    'totalOfferDis': totalOfferDis,
    'ser': ser,
    'no': no,
    'firstName': firstName,
    'userId': userId,
    'items': items
        .map((item) => {
              'mealImage': item.mealImage,
              'itemNet': item.net,
              'offerDis': item.offerDis,
              'itemId': item.id,
              'itemCode': item.code,
              'itemTitle': item.title,
              'itemPrice': item.price,
              'itemQuantity': item.quantity,
              'itemTax': item.tax,
              'itemSizeId': item.sizeId,
              'itemTotal': item.itemTotal,
              'itemSizeName': item.sizeName,
              'addedToppings': toJson(item.addedToppings),
              'removedIngredients': item.removedIngredients,
            })
        .toList(),
    'totalPrice': total,
    'dateTime': dateTime,
  };
}

toJson(toppings) {
  toppings as List<AddedTopping>;
  return toppings
      .map((topping) => {
            'toppingTitle': topping.toppingTitle,
            'toppingId': topping.toppingId,
            'toppingSizeId': topping.toppingSizeId,
            'toppingSizeName': topping.toppingSizeName,
            'toppingSizePrice': topping.toppingSizePrice,
          })
      .toList();
}

class Orders {
  final List<Order> orders;
  //String userToken;
  //String userId;
  const Orders({this.orders = const <Order>[]});
}
