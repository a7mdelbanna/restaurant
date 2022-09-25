import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant/data/localservices/cache_local_services.dart';
import 'package:restaurant/data/repositories/auth_repository.dart';
import 'package:restaurant/view/screens/home_screen.dart';

import '../../../../data/model/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthInitial());
  AuthRepository authRepository;
  String verificationId = '';
  final FirebaseFirestore usersRef = FirebaseFirestore.instance;
  IconData loginPasswordIcon = Icons.visibility;
  IconData registerPasswordIcon = Icons.visibility;
  IconData registerConfirmPasswordIcon = Icons.visibility;
  bool loginPasswordVis = true;
  bool registerPasswordVis = true;
  bool registerConfirmPasswordVis = true;
  static UserModel user = UserModel(
      delAddresses: [],
      favourites: [],
      firstName: '',
      lastName: '',
      uId: '',
      phone: '',
      email: '',
      apartmentNo: '',
      birthdayDate: '',
      buildingNo: '',
      cityName: '',
      floorNo: '',
      street: '');
  register({required String phone}) async {
    try {
      emit(RegisterLoadingState());
      await authRepository.verifyPhone(phone, const Duration(seconds: 60),
          (PhoneAuthCredential credential) {
        authRepository.completeSignIn(phone: phone, credential: credential);
      }, (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      }, (String verificationId, int? resendToken) async {
        this.verificationId = verificationId;
      }, (String verificationId) {});
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(), toastLength: Toast.LENGTH_SHORT);
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(), toastLength: Toast.LENGTH_SHORT);
    }
  }

  Future completeSignIn({
    required String otp,
    required String phone,
  }) async {
    try {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);

      // Sign the user in (or link) with the credential
      await authRepository
          .completeSignIn(credential: credential, phone: phone)
          .then((value) async {
        user.phone = phone;
        user.uId = SharedCache.getUIDByPhone(phone) ?? '';
        if (user.uId != '') {
          emit(RegisterLoadedState(user));
        }
        print('1Done');
      });
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT, // length
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT, // length
      );
    }
  }

  Future completePersonalInfo(
      {required String lastName,
      required String firstName,
      required String birthdayDate,
      required String email}) async {
    try {
      emit(RegisterLoadingState());
      await authRepository
          .completePersonalInfo(
        lastName: lastName,
        firstName: firstName,
        birthdayDate: birthdayDate,
        email: email,
      )
          .then((value) {
        user.birthdayDate = birthdayDate;
        user.firstName = firstName;
        user.lastName = lastName;
        user.email = email;
        emit(RegisterLoadedState(user));

        print('2Done');
      });
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT, // length
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT, // length
      );
    }
  }

  Future completeAddressInfo(
      {required String cityName,
      required String street,
      required String buildingNo,
      required String floorNo,
      required String apartmentNo,
      required String lat,
      required String long}) async {
    try {
      emit(RegisterLoadingState());
      await authRepository
          .completeAddressInfo(
              cityName: cityName,
              street: street,
              apartmentNo: apartmentNo,
              buildingNo: buildingNo,
              floorNo: floorNo,
              lat: lat,
              long: long)
          .then((value) {
        user.cityName = cityName;
        user.street = street;
        user.buildingNo = buildingNo;
        user.apartmentNo = apartmentNo;
        user.floorNo = floorNo;
        user.lat = lat;
        user.long = long;
        emit(RegisterLoadedState(user));
        SharedCache.setLastLoggedIn('lastUser', user.uId);
        SharedCache.setKeepLogged('keepLogged', true);
        print('3Done');
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT, // length
        );
      });
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT, // length
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT, // length
      );
    }
  }

  getUserId() {
    return user.uId ?? '';
  }

  sighOut() {
    SharedCache.setKeepLogged('keepLogged', false);
  }

  UserModel getUserData() {
    return user;
  }

  Future changeUserDelAddresses(String address, bool add, int index) async {
    List<String> tempList = [];
    if (add) {
      if (user.delAddresses!.isNotEmpty) {
        tempList = List.from(user.delAddresses!);
      }
      tempList.add(address);
      if (user.delAddresses!.contains(address) == false) {
        await authRepository
            .changeUserAddresses(tempList, user.uId)
            .then((value) => user.delAddresses!.add(address))
            .onError((error, stackTrace) => Fluttertoast.showToast(
                msg: 'Error saving address', toastLength: Toast.LENGTH_SHORT));
      }
    } else {
      if (user.delAddresses!.isNotEmpty) {
        tempList = List.from(user.delAddresses!);
      }
      tempList.removeAt(index);
      await authRepository
          .changeUserAddresses(tempList, user.uId)
          .then((value) => user.delAddresses!.removeAt(index));
    }
  }

  List<String> getUserDelAddresses() {
    return user.delAddresses ??
        [
          '6 october,giza jkjhkjh op ipo',
          '6 october,giza gfgkj td ytd',
          '6 october,giza str ytrftyr',
          '6 october,giza etrdryt tiug'
        ];
  }

  getUserDataById(
    uid,
  ) async {
    try {
      if (uid != '') {
        await usersRef.collection('Users').doc(uid).get().then((value) async {
          final data = value.data() as Map<dynamic, dynamic>;
          print('insideIfLogin');
          user = UserModel.fromJson(data);
          emit(LoginLoadedState(user));
          SharedCache.setLastLoggedIn('lastUser', user.uId);
          SharedCache.setKeepLogged('keepLogged', true);
        });
      } else {
        Fluttertoast.showToast(
          msg: 'No Account associated with that number'.toUpperCase(),
          toastLength: Toast.LENGTH_SHORT, // length
        );
      }
    } on Exception catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT, // length
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT, // length
      );
    }
  }

  getUserAddress() {
    return '${user.street},${user.cityName},Building: ${user.buildingNo},floor: ${user.floorNo},Apartment: ${user.apartmentNo} ';
  }

  toggleLoginPasswordVisibility() {
    emit(PasswordVisibilityState());
    loginPasswordVis = !loginPasswordVis;
    loginPasswordIcon =
        loginPasswordVis ? Icons.visibility : Icons.visibility_off;
    emit(LoginPasswordVisibility());
  }

  toggleRegisterPasswordVisibility() {
    emit(PasswordVisibilityState());
    registerPasswordVis = !registerPasswordVis;
    registerPasswordIcon =
        registerPasswordVis ? Icons.visibility : Icons.visibility_off;
    emit(RegisterPasswordVisibility());
  }

  toggleRegisterConfirmPasswordVisibility() {
    emit(PasswordVisibilityState());
    registerConfirmPasswordVis = !registerConfirmPasswordVis;
    registerConfirmPasswordIcon =
        registerConfirmPasswordVis ? Icons.visibility : Icons.visibility_off;
    emit(RegisterConfirmPasswordVisibility());
  }

  Future<dynamic> login({
    required BuildContext context,
    required String phone,
  }) async {
    try {
      emit(LoginLoadingState());

      String uid = SharedCache.getUIDByPhone(phone) ?? '';
      if (uid != '') {
        await usersRef.collection('Users').doc(uid).get().then((value) async {
          final data = value.data() as Map<dynamic, dynamic>;
          user = UserModel.fromJson(data);
          emit(LoginLoadedState(user));
          SharedCache.setLastLoggedIn('lastUser', user.uId);
          SharedCache.setKeepLogged('keepLogged', true);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        });
      } else {
        Fluttertoast.showToast(
          msg: 'No Account associated with that number'.toUpperCase(),
          toastLength: Toast.LENGTH_SHORT, // length
        );
      }
    } on Exception catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT, // length
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT, // length
      );
    }
  }
}
