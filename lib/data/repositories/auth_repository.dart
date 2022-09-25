import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant/data/model/user_model.dart';
import 'package:restaurant/data/webservices/auth_web_services.dart';

class AuthRepository {
  AuthWebServices authWebServices;
  AuthRepository(this.authWebServices);

  Future verifyPhone(String phoneNumber, timeout, verificationCompleted,
      verificationFailed, codeSent, codeAutoRetrievalTimeout) async {
    await authWebServices
        .verifyPhone(phoneNumber, timeout, verificationCompleted,
            verificationFailed, codeSent, codeAutoRetrievalTimeout)
        .then((value) {})
        .catchError((error, stackTrace) {
      return Future(error);
    });
  }

  Future completeSignIn(
      {required PhoneAuthCredential credential, required String phone}) async {
    try {
      await authWebServices.completeSignIn(
          phone: phone, credential: credential);
    } on Exception catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future completePersonalInfo(
      {required String lastName,
      required String firstName,
      required String birthdayDate,
      required String email}) async {
    try {
      await authWebServices.completePersonalInfo(
        lastName: lastName,
        firstName: firstName,
        birthdayDate: birthdayDate,
        email: email,
      );
    } on Exception catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
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
      await authWebServices.completeAddressInfo(
          cityName: cityName,
          street: street,
          apartmentNo: apartmentNo,
          buildingNo: buildingNo,
          floorNo: floorNo,
          lat: lat,
          long: long);
    } on Exception catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> login(
      {required String phone, required String password}) async {
    try {
      final data = await authWebServices.login(phone: phone, password: password)
          as Map<dynamic, dynamic>;
      print('insideAuthRepo');
      print(data);
      UserModel user = UserModel.fromJson(data);
      print(user.uId);
      return user;
    } on Exception {
      print('errorrrrr');
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future changeUserAddresses(List<String> addresses, uid) async {
    try {
      await authWebServices
          .changeUserAddresses(addresses, uid)
          .then((value) => true)
          .catchError(() {});
    } catch (e) {}
  }
}
