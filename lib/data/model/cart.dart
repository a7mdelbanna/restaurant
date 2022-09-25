// import 'package:equatable/equatable.dart';
//
// class CartItem {
//   final String id;
//   final double price;
//   final String title;
//   final String image;
//   final String size;
//   int quantity;
//   final List<String> addedExtraIngredients;
//   final List<String> removedIngredients;
//
//   CartItem(
//       {required this.image,
//       required this.size,
//       required this.id,
//       required this.price,
//       required this.title,
//       required this.addedExtraIngredients,
//       required this.removedIngredients,
//       this.quantity = 1});
// }
//
// class Cart extends Equatable {
//   final List<CartItem> cartItems;
//   List<CartItem> get items {
//     return [...cartItems];
//   }
//
//   // Map itemQuantity(List<CartItem> cartItems) {
//   //   var quantity = Map();
//   //   cartItems.forEach((item) {
//   //     if (!quantity.containsKey(item)) {
//   //       quantity[item] = item.quantity;
//   //     } else {
//   //       quantity[item] += item.quantity;
//   //     }
//   //     print(quantity.keys.length);
//   //   });
//   //   return quantity;
//   // }
//
//   const Cart({this.cartItems = const <CartItem>[]});
//
//   double get itemsTotal =>
//       cartItems.fold(0, (total, item) => total + (item.price * item.quantity));
//   String get itemsTotalString => itemsTotal.toStringAsFixed(2);
//
//   double get delivery => 5;
//   String get deliveryString => delivery.toStringAsFixed(2);
//   double get totalTax => 5;
//   String get totalTaxString => totalTax.toStringAsFixed(2);
//
//   double net(
//     itemsTotal,
//     totalTax,
//     totalVat,
//   ) {
//     return itemsTotal + totalTax + totalVat;
//   }
//
//   String get netString =>
//       net(itemsTotal, totalTax, delivery).toStringAsFixed(2);
//   @override
//   List<Object?> get props => [cartItems];
// }
import 'package:equatable/equatable.dart';

// part 'cart_model.g.dart';

// @HiveType(typeId: 77)
class CartItem extends Equatable {
  late final String id;
  late final String code;
  late final String title;
  late double? price;
  late String sizeId;
  late String sizeName;
  late double offerDis;
  late double tax;
  late int quantity;
  late final String userId;
  late double? itemTotal;
  late String mealImage;
  late double net;
  late List<AddedTopping> addedToppings;
  late List<String> removedIngredients;

  CartItem({
    required this.offerDis,
    required this.mealImage,
    required this.addedToppings,
    required this.removedIngredients,
    required this.userId,
    required this.sizeId,
    required this.sizeName,
    required this.tax,
    required this.id,
    required this.code,
    required this.title,
    required this.price,
    required this.quantity,
    required this.itemTotal,
    required this.net,
  });
  CartItem.fromJson(Map<String, dynamic> json) {
    sizeId = json['itemSizeId'];
    removedIngredients = removedIngredientsFromJson(json['removedIngredients']);
    addedToppings = addedToppingFromJson(json['addedToppings']);
    mealImage = json['mealImage'];
    sizeName = json['itemSizeName'];
    net = json['itemNet'] + 0.0;
    tax = json['itemTax'] + 0.0;
    offerDis = json['offerDis'] + 0.0;
    id = json['itemId'];
    code = json['itemCode'];
    title = json['itemTitle'];
    price = json['itemPrice'] + 0.0;
    quantity = json['itemQuantity'];
    itemTotal = json['itemTotal'] + 0.0;

    // userId = json['userId'];
  }
  @override
  List<Object?> get props => [
        itemTotal,
        sizeId,
        sizeName,
        tax,
        id,
        code,
        title,
        price,
        quantity,
        net,
        userId,
      ];
  removedIngredientsFromJson(List<dynamic> json) {
    List<String> removedIngredients = [];
    if (json.isNotEmpty) {
      for (var element in json) {
        removedIngredients.add(element);
      }
    }
    return removedIngredients;
  }

  addedToppingFromJson(List<dynamic> json) {
    List<AddedTopping> addedToppings = [];
    if (json.isNotEmpty) {
      for (var element in json) {
        AddedTopping addedTopping = AddedTopping(
            toppingTitle: element['toppingTitle'],
            toppingId: element['toppingId'],
            toppingSizeId: element['toppingSizeId'],
            toppingSizeName: element['toppingSizeName'],
            toppingSizePrice: element['toppingSizePrice']);
        addedToppings.add(addedTopping);
      }
    }

    return addedToppings;
  }
}

class Cart extends Equatable {
  final List<CartItem> cartItems;
  List<CartItem> get items {
    return [...cartItems];
  }

  Map itemQuantity(List<CartItem> cartItems) {
    var quantity = Map();
    cartItems.forEach((item) {
      if (!quantity.containsKey(item)) {
        quantity[item] = item.quantity;
      } else {
        quantity[item] += item.quantity;
      }
      print(quantity.keys.length);
    });
    return quantity;
  }

  const Cart({this.cartItems = const <CartItem>[]});

  double get itemsTotal =>
      cartItems.fold(0, (total, item) => total + item.itemTotal!);
  String get itemsTotalString => itemsTotal.toStringAsFixed(2);

  double get totalTax => cartItems.fold(
      0,
      (total, item) =>
          total + ((item.tax / 100) * item.price! * item.quantity));
  String get totalTaxString => totalTax.toStringAsFixed(2);
  // double get totalOfferDis {
  //   Offers offers = Offers();
  //   List<CartItem> inOffer = [];
  //   List<OfferItem>? offersItems = [];
  //   bool itemInOffer = false;
  //   double totalOffer = 0.0;
  //   for (CartItem cartItem in cartItems) {
  //     itemInOffer = offers.isItemInOfferOne(
  //       itemCode: cartItem.code,
  //       quantity: cartItem.quantity,
  //       unitId: cartItem.unitId,
  //     );
  //
  //     if (itemInOffer) {
  //       print('insideIteminOfferCheck');
  //       inOffer.add(cartItem);
  //       print(inOffer.length);
  //       print(inOffer.first.offerDis);
  //       print(cartItem.offerDis);
  //     }
  //     totalOffer = inOffer.fold(
  //         0, (total, item) => total + ((item.offerDis!) * item.quantity));
  //     print(totalOffer);
  //   }
  //   // if (itemInOffer == false) {
  //   //   offersItems = offers.isItemInOfferTwo(cartItems: cartItems);
  //   //   print(offersItems.length);
  //   //   if (offersItems.isNotEmpty) {
  //   //     for (OfferItem offerItem in offersItems) {
  //   //       for (CartItem cartItem in cartItems) {
  //   //         if ('0248625478365' == offerItem.itemCode ||
  //   //             offerItem.itemCode == '02154879623258') {
  //   //           inOffer.add(cartItem);
  //   //         }
  //   //       }
  //   //     }
  //   //     totalOffer = inOffer.fold(
  //   //         0, (total, item) => total + ((item.offerDis!) * item.quantity));
  //   //     print(totalOffer);
  //   //   }
  //   // }
  //
  //   return totalOffer;
  // }

  // String get totalOfferDisString => totalOfferDis.toStringAsFixed(2);
  double net(
    itemsTotal,
  ) {
    return itemsTotal;
  }

  String get netString => net(
        itemsTotal,
        //     totalTax,
      ).toStringAsFixed(2);
  @override
  List<Object?> get props => [cartItems];
}

class AddedTopping {
  late String toppingTitle;
  late String toppingId;
  late String toppingSizeId;
  late String toppingSizeName;
  late double toppingSizePrice;
  AddedTopping({
    required this.toppingTitle,
    required this.toppingId,
    required this.toppingSizeId,
    required this.toppingSizeName,
    required this.toppingSizePrice,
  });
}
