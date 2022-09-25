// import 'package:hive/hive.dart';
//
// import '../model/cart.dart';
//
// class CartLocalServices {
//   static Box<CartItem> hiveBox(String username) => Hive.box<CartItem>('cart');
//
//   List<CartItem> getItems(final String username) {
//     final items = hiveBox(username)
//         .values
//         .where((element) {
//           return element.username == username;
//         })
//         .toList()
//         .cast<CartItem>();
//     print(items.length);
//     return items.toList();
//   }
//
//   void addItem(
//     CartItem cartItem,
//     final String username,
//   ) async {
//     final box = hiveBox(username);
//     await box.add(cartItem);
//     print('iteeeeeeeeeemAddedToLocal');
//     print('itemAdded');
//   }
//
//   Future<void> removeItem(
//       final CartItem cartItem, final String username) async {
//     final box = hiveBox(username);
//     final itemToRemove = box.values.firstWhere(
//         (element) => element.id == cartItem.id && element.username == username);
//     await itemToRemove.delete();
//   }
//
//   Future<void> updateItem(
//       final CartItem cartItem, final String username) async {
//     final box = hiveBox(username);
//     final itemsToEdit = box.values.firstWhere(
//         (element) => element.id == cartItem.id && element.username == username);
//     final usernamekey = itemsToEdit.key;
//     await box.put(usernamekey, cartItem);
//   }
//
//   clearBox(username) async {
//     print('insideClearBox');
//     final box = hiveBox(username);
//     await box.clear();
//   }
// }
