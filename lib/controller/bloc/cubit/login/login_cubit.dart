// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:wholesaleproject/bloc/cubit/login/login_state.dart';
// import 'package:wholesaleproject/config/const.dart';
//
// import '../../../data/localservices/cache_local_services.dart';
// import '../../../data/model/user_model.dart';
// import '../../../presentation/screens/home_screen.dart';
//
// class LoginCubit extends Cubit<LoginStates> {
//   String phone = '';
//   String password = '';
//   String? uid = '';
//   bool isChecked = false;
//   bool isPassword = true;
//   bool forgetPasswordChecked = false;
//   IconData suffix = Icons.visibility_outlined;
//   var data;
//
//   LoginCubit() : super(LoginGetDataInitialState());
//
//   static LoginCubit get(context) => BlocProvider.of(context);
//   UserModel user = UserModel(
//       lat: '',
//       long: '',
//       username: '',
//       uId: '',
//       phone1: '',
//       email: '',
//       password: '',
//       place: '',
//       favourites: []);
//
//   Future LogIn(
//     context, {
//     required String phoneController,
//     required String passwordController,
//   }) async {
//     emit(LoginGetDataLoadingState());
//
//     try {
//       uid = CasheHelper.getData(key: phoneController);
//       if (uid == null) {
//         Fluttertoast.showToast(
//           msg: TextVar.incorrect_Logindata,
//           toastLength: Toast.LENGTH_SHORT, // length
//         );
//         emit(LoginGetDataErrorState(TextVar.incorrect_Logindata));
//       }
//       DatabaseReference ordersRef = FirebaseDatabase.instance.ref('users/$uid');
//       DatabaseEvent? event = await ordersRef.once();
//
//       data = event.snapshot.value;
//       print(data);
//       print(data['phone']);
//       print(data['password']);
//       phone = data['phone'];
//       password = data['password'];
//
//       if (phone == phoneController && password == passwordController) {
//         user = UserModel.fromJsonUser(data);
//         if (isChecked) {
//           CasheHelper.putData(key: 'lastLogin', value: phoneController);
//         }
//         ;
//         print(user.uId);
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HomeScreen(
//               loggedIn: true,
//               stored: false,
//             ),
//           ),
//         );
//       } else {
//         Fluttertoast.showToast(
//           msg: TextVar.incorrect_Logindata,
//           toastLength: Toast.LENGTH_SHORT, // length
//         );
//       }
//       emit(LoginGetDataSuccessState());
//       return (data);
//     } catch (error) {
//       print(error.toString());
//       return error;
//     }
//   }
//
//   getUsersList(UserModel user) async {
//     List<UserModel> users = [];
//
//     if (user.isAdmin == true) {
//       try {
//         DatabaseReference ordersRef = FirebaseDatabase.instance.ref('users/');
//         DatabaseEvent? event = await ordersRef.once();
//
//         final loadedUsers = event.snapshot.value as dynamic;
//
//         loadedUsers.forEach((userId, userData) {
//           UserModel user = UserModel.fromJsonUser(userData);
//           users.add(user);
//         });
//         return users;
//       } catch (e) {}
//     }
//   }
//
//   getUserIdByphone(String phone) async {
//     String uid = await CasheHelper.getData(key: phone) ?? '';
//     return uid;
//   }
//
//   Future setUserLocation(
//     String long,
//     String lat,
//   ) async {
//     DatabaseReference userRef =
//         FirebaseDatabase.instance.ref('users/${user.uId}');
//     await userRef.update({
//       'long': long,
//       'lat': lat,
//     });
//     user.long = long;
//     user.lat = lat;
//   }
//
//   Future updateUserPassword(
//     String password,
//     String confirmPassword,
//     uid,
//   ) async {
//     emit(UpdatePasswordInitial());
//     if (password == confirmPassword) {
//       try {
//         DatabaseReference userRef =
//             FirebaseDatabase.instance.ref('users/${uid}');
//         await userRef.update({
//           'password': password,
//         });
//
//         emit(PasswordUpdated());
//         return true;
//       } catch (e) {
//         return e;
//       }
//     } else {
//       return false;
//     }
//   }
//
//   Future getPasswordByAccInfo(String phonenumber, String name) async {
//     String password;
//     String username;
//     String phone;
//     emit(ForgetPasswordInitial());
//     uid = CasheHelper.getData(key: phonenumber);
//     if (uid == null) {
//       emit(ForgetPasswordCheckFailed());
//       return false;
//     }
//     try {
//       DatabaseReference ordersRef = FirebaseDatabase.instance.ref('users/$uid');
//       DatabaseEvent? event = await ordersRef.once();
//       data = event.snapshot.value;
//       username = data['username'];
//       phone = data['phone'];
//       password = data['password'];
//
//       if (phone == phonenumber && username == name) {
//         emit(ForgetPasswordChecked(password));
//         return password;
//       }
//     } catch (e) {
//       emit(ForgetPasswordCheckFailed());
//       return true;
//     }
//     emit(ForgetPasswordCheckFailed());
//     return false;
//   }
//
//   Future<UserModel> getUserDataById(id) async {
//     print('insideGetUserById');
//     print(id);
//     UserModel user;
//     try {
//       DatabaseReference ordersRef = FirebaseDatabase.instance.ref('users/$id');
//       DatabaseEvent? event = await ordersRef.once();
//       data = event.snapshot.value;
//       user = UserModel.fromJsonUser(data);
//       print(await data);
//       print(await user.phone1);
//     } catch (e) {
//       print(e);
//       user = UserModel(
//           username: '',
//           uId: '',
//           phone1: '',
//           email: '',
//           password: '',
//           place: '',
//           lat: '',
//           long: '');
//     }
//     return user;
//   }
//
//   void ChangeCheckBoxState() {
//     isChecked = !isChecked;
//
//     CasheHelper.isChecked(
//       key: 'isChecked',
//       value: isChecked,
//     ).then((value) {
//       emit(LoginChangeCheckBoxState());
//     });
//   }
//
//   void ChangePasswordVisibility() {
//     isPassword = !isPassword;
//     suffix =
//         isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
//     emit(LoginChangePasswordVisibility());
//   }
//
//   UserModel getUserData() {
//     print('getUserData');
//     print(user.uId);
//     print(user.username);
//     return user;
//   }
//
//   String getUserID() {
//     print('insideGetUserId');
//     print(user.uId);
//     return user.uId!;
//   }
//
//   List<String> getUserFav() {
//     return user.favourites ?? [];
//   }
//
//   List<UserPrice> getUserPrices() {
//     return user.userPrices ?? [];
//   }
//
//   addToFav(itemCode) async {
//     print('itemAddedTofav' + itemCode);
//     user.favourites = user.favourites ?? [];
//     user.favourites!.add(itemCode);
//     print(user.uId);
//     List<String> newFav = user.favourites!.toList();
//     try {
//       DatabaseReference userIDRef = FirebaseDatabase.instance.ref('users/$uid');
//
//       await userIDRef.update({'favourites': newFav});
//
//       return data;
//     } catch (e) {
//       return (data);
//     }
//   }
//
//   void removeFromFav(itemCode) async {
//     print('itemRemovedFromFav' + itemCode);
//     user.favourites!.remove(itemCode);
//     List<String> newFav = user.favourites!.toList();
//
//     try {
//       DatabaseReference userIDRef = FirebaseDatabase.instance.ref('users/$uid');
//
//       await userIDRef.update({'favourites': newFav});
//
//       return data;
//     } catch (e) {
//       return (data);
//     }
//   }
// }
