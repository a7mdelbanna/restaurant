import 'meal.dart';

class Offer {
  late final String id;
  late final String? image;
  late final String title;
  late final String? startDate;
  late final String? endDate;
  late final String? desc;
  late final List<OfferItem> offerItems;
  late final int offerType;
  late final bool? active;

  Offer({
    required this.offerType,
    required this.offerItems,
    this.image,
    required this.id,
    this.active,
    this.startDate,
    required this.title,
    this.endDate,
    this.desc,
  });

  // Offer.fromJson(Map<String, dynamic> json) {
  //   title = json['offerTitle'];
  //   startDate = json['startDate'];
  //   endDate = json['endDate'];
  //   oldPrice = json['oldPrice'];
  //   newPrice = json['newPrice'];
  //   image = json['image'];
  //   active = json['active'];
  // }

}

List<Offer> offersList = [];

class OfferItem {
  late final String mealCode;
  late final double mealPrice;
  late final double mealDisc;
  late final int quantity;
  late final MealSize mealSize;
  OfferItem({
    required this.mealCode,
    required this.mealDisc,
    required this.mealPrice,
    required this.quantity,
    required this.mealSize,
  });
  OfferItem.fromJson(Map<String, dynamic> json) {
    mealCode = json['mealCode'];
    mealPrice = json['mealPrice'];
    mealDisc = json['mealDisc'];
    quantity = json['mealQuantity'];
    mealSize = MealSize.fromJson(json);
  }
}

class Offers {
  final List<Offer> offers = [];
  List<OfferItem> offerItems = [];
  List<Offer> get items {
    return [...offers];
  }
  // Offers({this.offers = const <Offer>[],});

  bool isItemInOfferOne(
      {required String mealCode,
      required int quantity,
      required String sizeId}) {
    for (Offer offer in offers) {
      if (offer.offerType == 1) {
        if (offer.active!) {
          for (OfferItem offerItem in offer.offerItems) {
            if (offerItem.mealCode == mealCode) {
              if (sizeId == offerItem.mealSize.sizeId) {
                if (quantity >= offerItem.quantity) {
                  return true;
                }
              }
            }
          }
        }
      }
    }
    return false;
  }

  // List<OfferItem> isItemInOfferTwo({
  //   required List<CartItem> cartItems,
  // }) {
  //   List<CartItem> cart = [...cartItems];
  //   print('insideIsItemInOffer');
  //   bool item1Found = false;
  //   late CartItem temp;
  //   bool item2Found = false;
  //   for (Offer offer in offers) {
  //     if (offer.offerType == 2) {
  //       if (offer.active!) {
  //         print('active==true');
  //         for (OfferItem offerItem in offer.offerItems) {
  //           print(offerItem.itemCode);
  //           print(offerItem.quantity);
  //           print(offerItem.itemUnit.unitId);
  //
  //           for (CartItem cartItem in cart) {
  //             if (cartItem.code == offerItem.itemCode &&
  //                 cartItem.quantity >= offerItem.quantity &&
  //                 cartItem.unitId == offerItem.itemUnit.unitId) {
  //               item1Found = true;
  //               temp = cartItem;
  //               print('item1True');
  //             }
  //           }
  //           cart.remove(temp);
  //           for (CartItem cartItem in cart) {
  //             if (cartItem.code == offerItem.itemCode &&
  //                 cartItem.quantity >= offerItem.quantity &&
  //                 cartItem.unitId == offerItem.itemUnit.unitId) {
  //               item2Found = true;
  //               print('item1True');
  //             }
  //           }
  //           if (item1Found == true) {
  //             if (item2Found == true) {
  //               return offer.offerItems;
  //             }
  //           }
  //         }
  //       }
  //     }
  //   }
  //   return [];
  // }
}
