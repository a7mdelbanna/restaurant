import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant/data/localservices/cache_local_services.dart';
import 'package:restaurant/data/model/user_model.dart';

class AuthWebServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore usersRef = FirebaseFirestore.instance;
  String uid = '';
  Future verifyPhone(String phoneNumber, timeout, verificationCompleted,
      verificationFailed, codeSent, codeAutoRetrievalTimeout) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: '+7$phoneNumber',
        timeout: timeout,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
      print('after verify');
    } on FirebaseAuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future completeSignIn({
    required PhoneAuthCredential credential,
    required String phone,
  }) async {
    try {
      await auth.signInWithCredential(credential);

      String uId = auth.currentUser!.uid;
      print(uId);
      print('insideSininComplete');
      uid = uId;
      UserModel user = UserModel(
          delAddresses: [''],
          favourites: [''],
          firstName: '',
          lastName: '',
          uId: uId,
          phone: phone,
          email: '',
          apartmentNo: '',
          birthdayDate: '',
          buildingNo: '',
          cityName: '',
          floorNo: '',
          street: '');

      await usersRef
          .collection('Users')
          .doc(uId)
          .set(user.userToJson(
            long: '',
            lat: '',
            isAdmin: false,
            favourites: [''],
            apartmentNo: '',
            birthdayDate: '',
            buildingNo: '',
            cityName: '',
            email: '',
            firstName: '',
            floorNo: '',
            lastName: '',
            phone: phone,
            street: '',
            uId: uId,
            delAddresses: [''],
          ))
          .then((value) {
        SharedCache.setPhoneUID(phone, uId);
        SharedCache.setLastNotCompletedRegister(phone);
        SharedCache.setRegisterCompleted('registerCompleted', 1);
      }).catchError((onError) {});
    } catch (e) {
      rethrow;
    }
  }

  Future completePersonalInfo(
      {required String firstName,
      required String lastName,
      required String email,
      required String birthdayDate}) async {
    if (uid == '') {
      String phone = SharedCache.getLastNotCompleted('notCompleted') ?? '';
      if (phone != '') {
        uid = SharedCache.getUIDByPhone(phone) ?? '';
      }
    }
    await usersRef.collection('Users').doc(uid).update({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'birthdayDate': birthdayDate,
    }).then((value) {
      SharedCache.setRegisterCompleted('registerCompleted', 2);
    }).catchError((onError) {});
  }

  Future completeAddressInfo(
      {required String cityName,
      required String street,
      required String apartmentNo,
      required String buildingNo,
      required String floorNo,
      required String lat,
      required String long}) async {
    if (uid == '') {
      String phone = SharedCache.getLastNotCompleted('notCompleted') ?? '';
      if (phone != '') {
        uid = SharedCache.getUIDByPhone(phone) ?? '';
      }
    }
    await usersRef.collection('Users').doc(uid).update({
      'lat': lat,
      'long': long,
      'cityName': cityName,
      'street': street,
      'buildingNo': buildingNo,
      'floorNo': floorNo,
      'apartmentNo': apartmentNo,
    }).then((value) {
      SharedCache.setRegisterCompleted('registerCompleted', 3);
    }).catchError((onError) {});
  }

  Future<dynamic> login(
      {required String phone, required String password}) async {
    String userPassword;
    try {




    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future changeUserAddresses(List<String> addresses, String uid) async {
    try {
      await usersRef.collection('Users').doc(uid).update({
        'delAddresses': addresses,
      }).then((value) {
        return true;
      }).catchError((onError) {});
    } on Exception catch (e) {
    } catch (e) {}
  }

  removeUserAddress() {}
}
