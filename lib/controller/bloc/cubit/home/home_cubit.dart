// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// import 'package:equatable/equatable.dart';
//
//
// part 'home_state.dart';
//
// class HomeCubit extends Cubit<HomeState> {
//   HomeCubit() : super(HomeInitial());
//   late UserModel user;
//
//   setUserData(UserModel user) {
//     print('insidesetUserModel');
//     print(user.uId);
//     print(user.username);
//     this.user = user;
//     print(this.user.uId);
//     print(this.user.username);
//   }
//
//   UserModel getUserData() {
//     return user;
//   }
//
//   getUserFav() {
//     return user.favourites ?? [];
//   }
//
//   List<UserPrice> getUserPrices() {
//     return user.userPrices ?? [];
//   }
//
//   getUserId() {
//     return user.uId;
//   }
//
//   addToFav(itemCode) async {
//     print('itemAddedTofav' + itemCode);
//     user.favourites = user.favourites ?? [];
//     user.favourites!.add(itemCode);
//     print(user.uId);
//     List<String> newFav = user.favourites!.toList();
//     try {
//       DatabaseReference userIDRef =
//           FirebaseDatabase.instance.ref('users/${user.uId}');
//
//       await userIDRef.update({'favourites': newFav});
//     } catch (e) {}
//   }
//
//   void removeFromFav(itemCode) async {
//     print('itemRemovedFromFav' + itemCode);
//     user.favourites!.remove(itemCode);
//     List<String> newFav = user.favourites!.toList();
//     print(user.uId);
//     try {
//       DatabaseReference userIDRef =
//           FirebaseDatabase.instance.ref('users/${user.uId}');
//
//       await userIDRef.update({'favourites': newFav});
//     } catch (e) {}
//   }
// }
