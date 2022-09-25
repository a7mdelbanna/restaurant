// import 'dart:core';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:wholesaleproject/bloc/cubit/register/register_state.dart';
// import 'package:wholesaleproject/data/localservices/cache_local_services.dart';
//
// import '../../../data/model/user_model.dart';
//
// class RegisterCubit extends Cubit<RegisterStates> {
//   // String username = "01091280003";
//
//   String verificationId = "";
//   String uId = '';
//   bool userUpdated = false;
//   RegisterCubit() : super(RegisterIntialState());
//
//   //
//   //  String? email;
//   //  String? phone;
//   //  String? password;
//   // // String? uId;
//   //  String? username;
//
//   static RegisterCubit get(context) => BlocProvider.of(context);
//   Future updateUserData(
//       String uid,
//       String long,
//       String lat,
//       String username,
//       String password,
//       String place,
//       String mail,
//       String phone2,
//       String phone) async {
//     try {
//       DatabaseReference userRef = FirebaseDatabase.instance.ref('users/$uid');
//       await userRef.update({
//         'place': place,
//         'username': username,
//         'phone': phone,
//         'phone2': phone2,
//         'email': mail,
//         'password': password
//       });
//       user = UserModel(
//           username: username,
//           uId: uId,
//           phone1: phone,
//           phone2: phone2,
//           email: mail,
//           password: password,
//           place: place,
//           lat: lat,
//           long: long);
//       userUpdated = true;
//       return user;
//     } catch (e) {
//       return false;
//     }
//   }
//
//   userDataUpdated() {
//     return userUpdated;
//   }
//
//   Future getUserLocation() async {
//     LocationPermission permission;
//     String _long;
//     String _lat;
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return PermissionDeniedException('Location services are disabled.');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return PermissionDeniedException(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     Position position = await Geolocator.getCurrentPosition();
//     _long = position.longitude.toString();
//     _lat = position.latitude.toString();
//     print(_long);
//     print(_lat);
// // setUserLocation(_long, _lat, uid)
//     // DatabaseReference userRef =
//     //     FirebaseDatabase.instance.ref('users/${user.uId}');
//     // await userRef.update({
//     //   'long': '_long',
//     //   'lat': '_lat',
//     // });
//     // user.lat = _lat;
//     // user.long = _long;
//     // print(user.long);
//     // print(user.lat);
//     return position;
//     print('insidecatchhhh');
//   }
//
//   Future phoneLogin({
//     required String phoneNumber,
//     String? email,
//     String? name,
//     String? uId,
//     String? password,
//     String? long,
//     String? lat,
//   }) async {
//     print('jjhi');
//     emit(RegisterLoadingState());
//
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: '+2$phoneNumber',
//       verificationCompleted: verificationCompleted,
//       verificationFailed: verificationFailed,
//       codeSent: codeSent,
//       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
//     );
//
//     print('now');
//
//     // InsertData(
//     //
//     //     phoneNumber,
//     //     email!,
//     //     name!,
//     //     password!,
//     // );
//   }
//
//   void verificationCompleted(PhoneAuthCredential credential) async {
//     print('verificationCompleted');
//     // emit(VerificationCompletedSuccess());
//     await signIn(credential);
//   }
//
//   void verificationFailed(FirebaseAuthException error) {
//     // print('verificationFailed : ${error.toString()}');
//     emit(RegisterErrorState(error.toString()));
//     print(error.toString());
//   }
//
//   void codeSent(String verificationId, int? resendToken) {
//     print('codeSent');
//
//     this.verificationId = verificationId;
//
//     print('this os ');
//
//     print(verificationId);
//
//     emit(RegisterSuccessState());
//
//     //
//     //  AddUser(
//     //   email: email!,
//     //   password: password!,
//     //   phone: phone!,
//     //   uId: uId!,
//     //   username: username!
//     //
//     // );
//   }
//
//   void codeAutoRetrievalTimeout(String verificationId) {
//     print('codeAutoRetrievalTimeout');
//   }
//
//   late UserModel user;
//   Future submitOTP({
//     required String otpCode,
//     required String email,
//     required String password,
//     required String username,
//     required String phone,
//     String? phone2,
//     String? place,
//     String? long,
//     String? lat,
//   }) async {
//     print('mmm');
//     print(otpCode);
//     PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId, smsCode: otpCode);
//
//     print('nnn');
//
//     await signIn(credential);
//
//     DatabaseReference userRef =
//         FirebaseDatabase.instance.reference().child('users');
//     // String uId2 = 'I8fmXiLWd3NBBeApW9Utdy89zAd2';
//     String uId2 = FirebaseAuth.instance.currentUser!.uid;
//     print(uId2);
//
//     user = UserModel(
//       username: username,
//       uId: uId2,
//       phone1: phone,
//       email: email,
//       password: password,
//       favourites: [],
//       phone2: phone2,
//       place: place,
//       long: long ?? '',
//       lat: lat ?? '',
//       isAdmin: false,
//       customerId: '',
//     );
//     print('user created');
//     userRef
//         .child(uId2)
//         .set(user.toMapUser(
//           uId: uId2,
//           username: username,
//           password: password,
//           phone: phone,
//           email: email,
//           phone2: phone2,
//           place: place,
//           favourites: [''],
//           long: long,
//           lat: lat,
//           isAdmin: false,
//           customerId: '',
//           customerName: '',
//           userPrices: [],
//         ))
//         .then((value) {
//       print('insideThenUserAddedToFirebase');
//       print(phone);
//       print(uId2);
//       CasheHelper.putData(key: phone, value: uId2);
//       emit(RegisterCreateUserSuccessState());
//     }).catchError((error) {
//       print(error.toString());
//       emit(RegisterCreateUserErrorState(error.toString()));
//     });
//     print(uId2);
//   }
//
//   UserModel getUserData() {
//     print('insideGetUserDataRegCubit');
//     print(user.uId);
//     print(user.username);
//     return user;
//   }
//
//   Future<void> signIn(PhoneAuthCredential credential) async {
//     print('kkk');
//     try {
//       await FirebaseAuth.instance.signInWithCredential(credential);
//
//       emit(PhoneOtpSumbitted());
//     } catch (error) {
//       emit(RegisterErrorState(error.toString()));
//
//       print(error.toString());
//     }
//   }
//
//   Future<void> logOut() async {
//     await FirebaseAuth.instance.signOut();
//   }
//
//   User getLoggedInUser() {
//     User firebaseUser = FirebaseAuth.instance.currentUser!;
//     return firebaseUser;
//   }
//
//   //
//   // Future AddUser({
//   //   required String email,
//   //   required String password,
//   //   required String phone,
//   //   required String uId,
//   //   required username,
//   // }) async {
//   //   emit(RegisterCreateUserLoadingState());
//   //
//   //   DatabaseReference userRef =
//   //       FirebaseDatabase.instance.reference().child('users');
//   //   // String uId = FirebaseAuth.instance.currentUser!.uid;
//   //
//   //   print('xxx');
//   //
//   //   print(uId);
//   //   userRef.child(uId).set({
//   //     'email': email,
//   //     'password': password,
//   //     'phone': phone,
//   //     'uId': uId,
//   //     'username': username,
//   //   }).then((value) {
//   //     emit(RegisterCreateUserSuccessState());
//   //   }).catchError((error) {
//   //     print(error.toString());
//   //     emit(RegisterCreateUserErrorState(error.toString()));
//   //   });
//   // }
//
//   IconData suffix = Icons.visibility_outlined;
//   IconData suffix2 = Icons.visibility_outlined;
//
//   bool isPassword = true;
//   bool isPassword2 = true;
//
//   void ChangePasswordVisibility_1() {
//     isPassword = !isPassword;
//
//     suffix =
//         isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
//     emit(Reg_ChangePasswordVisibility_1());
//   }
//
//   void ChangePasswordVisibility_2() {
//     isPassword2 = !isPassword2;
//
//     suffix2 =
//         isPassword2 ? Icons.visibility_outlined : Icons.visibility_off_outlined;
//     emit(Reg_ChangePasswordVisibility_2());
//   }
// }
