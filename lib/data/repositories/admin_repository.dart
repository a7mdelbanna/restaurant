//
//
// import '../exceptions.dart';
// import '../webservices/admin_web_services.dart';
//
// class AdminRepository {
//   AdminWebServices adminWebServices;
//
//   AdminRepository(this.adminWebServices);
//
//   Future<List<UserModel>> getAllUsers() async {
//     try {
//       final users = await adminWebServices.getAllUsersFirebaseSDK();
//
//       final List<UserModel> loadedUsers = [];
//
//       if (users == null) {
//         return [];
//       }
//       users.forEach((userId, value) {
//         UserModel user = UserModel.fromJsonUser(value);
//         loadedUsers.add(user);
//       });
//       print(loadedUsers.length);
//       print(loadedUsers.first.phone1);
//       return loadedUsers;
//     } on TimeOutException catch (e) {
//       rethrow;
//     } on DataException catch (e) {
//       rethrow;
//     }
//   }
//
//   // Future<List<Order>> getAllOrders() async {
//   //   try {
//   //     final orders = await adminWebServices.getAllOrdersFirebaseSDK();
//   //
//   //     final List<Order> loadedOrders = [];
//   //
//   //     if (orders == null) {
//   //       return [];
//   //     }
//   //     orders.forEach((userId, orders) {
//   //      orders as List<Map<dynamic,dynamic>>;
//   //      orders.forEach((element) {
//   //        Order order=Order.fromJson(element.keys, element.values);
//   //      });
//   //     });
//   //     print(loadedUsers.length);
//   //     print(loadedUsers.first.phone1);
//   //     return loadedUsers;
//   //   } on TimeOutException catch (e) {
//   //     rethrow;
//   //   } on DataException catch (e) {
//   //     rethrow;
//   //   }
//   // }
//
// }
