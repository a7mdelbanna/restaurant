// import 'dart:async';
// import 'dart:io';
//
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:wholesaleproject/data/model/cart_model.dart';
//
// import '../../../data/model/order_model.dart';
// import '../../../data/model/user_model.dart';
//
// part 'admin_state.dart';
//
// class AdminCubit extends Cubit<AdminState> {
//   AdminCubit() : super(AdminInitial());
//   static List<UserModel> users = [];
//   static List<Order> orders = [];
//   static List<CartItem> cartItems = [];
//   getData() async {
//     print('insideGetDate');
//     await order;
//     await user;
//     print(users.length);
//     print(orders.length);
//   }
//
//   filterOrdersByUserId(
//     List<Order> allOrders,
//     String phone,
//   ) {
//     List<UserModel> filteredUsers = [];
//     List<Order> filteredOrders = [];
//
//     for (UserModel user in users) {
//       if (user.phone1!.contains(phone)) {
//         filteredUsers.add(user);
//       }
//     }
//     for (UserModel user in filteredUsers) {
//       for (Order order in allOrders) {
//         if (order.userId == user.uId) {
//           filteredOrders.add(order);
//         }
//       }
//     }
//     return filteredOrders;
//   }
//
//   addUser(UserModel user) {
//     users.add(user);
//   }
//
//   addOrder(Order order) {
//     orders.add(order);
//   }
//
//   Future uploadImage() async {
//     final _firebaseStorage = FirebaseStorage.instance;
//     final _imagePicker = ImagePicker();
//     XFile? image;
//     await Permission.photos.request();
//     var permissionStatus = await Permission.photos.status;
//     if (permissionStatus.isGranted) {
//       //Select Image
//       print('insidePickImage');
//       image = await _imagePicker.pickImage(source: ImageSource.gallery);
//       var filePath = File(image!.path);
//       var fileName = File(image.name);
//
//       if (image != null) {
//         //Upload to Firebase
//         print('insideUploadImage');
//         var snapshot = await _firebaseStorage
//             .ref()
//             .child('Items/$fileName')
//             .putFile(filePath);
//         var downloadUrl = await snapshot.ref.getDownloadURL();
//         print(downloadUrl);
//         return downloadUrl;
//       } else {
//         print('No Image Path Received');
//         return false;
//       }
//     } else {
//       print('Permission not granted. Try Again with permission access');
//       return true;
//     }
//   }
//
//   filterUsersByName(List<UserModel> allUsers, String userName) {
//     List<UserModel> filteredUsers = [];
//     filteredUsers =
//         allUsers.where((user) => user.username!.contains(userName)).toList();
//     return filteredUsers;
//   }
//
//   getCustomerNameByPhone(phone) {}
//   filterUsersByNumber(List<UserModel> allUsers, String userNumber) {
//     List<UserModel> filteredUsers = [];
//     print(allUsers.first.phone1!);
//     filteredUsers =
//         allUsers.where((user) => user.phone1!.contains(userNumber)).toList();
//     return filteredUsers;
//   }
//
//   List<CartItem> getItemsFromOrdersList(List<Order> allOrders) {
//     CartItem cartItem;
//     print('getItemsFromOrdersList');
//     List<CartItem> tempList = [];
//     allOrders.forEach((order) {
//       order.itemsList.forEach((item) {
//         if (tempList.isNotEmpty) {
//           for (CartItem tempItem in tempList) {
//             if (tempItem.code == item.code) {
//               tempItem.quantity = tempItem.quantity + item.quantity;
//               tempItem.itemTotal = tempItem.itemTotal! + item.itemTotal!;
//             } else {
//               cartItem = CartItem(
//                   username: '',
//                   unitId: item.unitId,
//                   unitAmount: item.unitAmount,
//                   unitName: item.unitName,
//                   vat: item.vat,
//                   tax: item.tax,
//                   code: item.code,
//                   id: item.id,
//                   title: item.title,
//                   price: item.price,
//                   quantity: item.quantity,
//                   itemTotal: item.itemTotal,
//                   offerDis: item.offerDis,
//                   net: item.net);
//               tempList.add(cartItem);
//             }
//           }
//         } else {
//           cartItem = CartItem(
//               username: '',
//               unitId: item.unitId,
//               unitAmount: item.unitAmount,
//               unitName: item.unitName,
//               vat: item.vat,
//               tax: item.tax,
//               code: item.code,
//               id: item.id,
//               title: item.title,
//               price: item.price,
//               quantity: item.quantity,
//               itemTotal: item.itemTotal,
//               offerDis: item.offerDis,
//               net: item.net);
//           tempList.add(cartItem);
//         }
//       });
//     });
//     print(tempList.length);
//     cartItems = tempList as List<CartItem>;
//     tempList = [];
//     return cartItems;
//   }
//
//   filterUserOrdersByItem(List<Order> allOrders, String itemName) {
//     List<Order> filteredOrders = [];
//     filteredOrders = allOrders.where((order) {
//       if (order.itemsList.any((item) {
//             if (item.title.contains(itemName)) {
//               return true;
//             } else {
//               return false;
//             }
//           }) ==
//           true) {
//         return true;
//       } else {
//         return false;
//       }
//     }).toList();
//     return filteredOrders;
//   }
//
//   filterUsersOrdersByUserInfo(
//       List<Order> allOrders, String searchedText, option) {
//     List<Order> filteredOrders = [];
//     if (option == 0) {
//       print('insideSearchBy1');
//       filteredOrders = allOrders
//           .where((order) => order.username.contains(searchedText))
//           .toList();
//       print(filteredOrders.length);
//     } else if (option == 1) {
//       print('insideSearchBy2');
//       filteredOrders = allOrders
//           .where((order) => order.phone.contains(searchedText))
//           .toList();
//       print(filteredOrders.length);
//     } else if (option == 2) {
//       print('insideSearchBy3');
//       filteredOrders = allOrders
//           .where((order) => order.customerName.contains(searchedText))
//           .toList();
//       print(filteredOrders.length);
//     }
//     return filteredOrders;
//   }
//
//   final _user = BehaviorSubject<UserModel>();
//   final _order = BehaviorSubject<Order>();
//   //Sink get updateUser => _user.sink;
//   //Stream<UserModel> get users => _user.stream;
//   disposeStreams() {
//     _user.close();
//     _order.close();
//   }
//
//   Stream<Stream<UserModel>> get user async* {
//     UserModel user;
//     List<UserModel> tempUsers = [];
//     DatabaseReference usersRef = FirebaseDatabase.instance.ref('users/');
//     usersRef.onValue.listen((event) {
//       for (var e in event.snapshot.children) {
//         user = UserModel.fromJsonUser(e.value as Map<dynamic, dynamic>);
//         if (users.contains(user)) {
//         } else {
//           _user.sink.add(user);
//         }
//       }
//     });
//     yield _user.stream;
//   }
//
//   Stream<Stream<Order>> get order async* {
//     Order order;
//     List<Order> tempOrder = [];
//     DatabaseReference ordersRef = FirebaseDatabase.instance.ref('Orders/');
//     ordersRef.onValue.listen((event) {
//       for (var e in event.snapshot.children) {
//         for (var element in e.children) {
//           Map<dynamic, dynamic> value = element.value as Map;
//           order = Order.fromJson(element.key, value);
//           if (orders.contains(order)) {
//           } else {
//             _order.sink.add(order);
//           }
//         }
//       }
//     });
//     yield _order.stream;
//   }
//
//   Stream<DatabaseEvent> get usersStream async* {
//     DatabaseReference usersRef = FirebaseDatabase.instance.ref('users/');
//     usersRef.onValue.map((event) async* {
//       yield event;
//     });
//   }
//
//   addToUsersList(UserModel user) {
//     users.add(user);
//   }
//
//   getAllUsers() {
//     return users;
//   }
//
//   getUserByuid(String uid) {
//     print(users.length);
//     return users.firstWhere((user) => user.uId == uid);
//   }
//
//   filterOrdersByDateRange(
//       List<Order> allorders, DateTime startDate, DateTime endDate) {
//     List<Order> filteredOrders = allorders.where((element) {
//       if (element.dateTime.isBefore(endDate) &&
//           element.dateTime.isAfter(startDate)) {
//         return true;
//       } else {
//         return false;
//       }
//     }).toList();
//     print(filteredOrders.length);
//     return filteredOrders;
//   }
// }
