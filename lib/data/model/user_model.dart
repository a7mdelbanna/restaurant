class UserModel {
  late String firstName;
  late String lastName;
  late String birthdayDate;
  late String email;
  late String phone;
  late String uId;
  late String cityName;
  late String street;
  late String buildingNo;
  late String floorNo;
  late String apartmentNo;
  late List<String>? favourites;
  late String long;
  late String lat;
  late bool isAdmin;
  List<String>? delAddresses;
  UserModel({
    this.delAddresses = const [''],
    required this.firstName,
    required this.lastName,
    required this.uId,
    required this.phone,
    required this.email,
    required this.apartmentNo,
    required this.birthdayDate,
    required this.buildingNo,
    required this.cityName,
    required this.floorNo,
    required this.street,
    this.favourites = const [],
    this.lat = '',
    this.long = '',
    this.isAdmin = false,
  });

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    delAddresses = addressesFromJson(json['delAddresses']) ?? [];
    uId = json['uId'];
    phone = json['phone'];

    street = json['street'];
    floorNo = json['floorNo'];
    cityName = json['cityName'];
    apartmentNo = json['apartmentNo'];
    buildingNo = json['buildingNo'];
    birthdayDate = json['birthdayDate'];
    favourites = favFromJson(json['favourites']) ?? [];
    long = json['long'];
    lat = json['lat'];
    isAdmin = json['isAdmin'];
  }
  favFromJson(List<dynamic> json) {
    List<String> fav = [];
    if (json != null) {
      for (var element in json) {
        fav.add(element);
      }
    }
    return fav;
  }

  addressesFromJson(List<dynamic> json) {
    List<String> addresses = [];
    if (json != null) {
      for (var element in json) {
        addresses.add(element);
      }
    }
    return addresses;
  }

  Map<String, dynamic> userToJson({
    email,
    firstName,
    lastName,
    birthdayDate,
    buildingNo,
    floorNo,
    street,
    cityName,
    apartmentNo,
    uId,
    phone,
    favourites,
    delAddresses,
    long,
    lat,
    isAdmin,
  }) {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'birthdayDate': birthdayDate,
      'phone': phone,
      'uId': uId,
      'email': email,
      'favourites': favourites,
      'cityName': cityName,
      'buildingNo': buildingNo,
      'floorNo': floorNo,
      'apartmentNo': apartmentNo,
      'street': street,
      'long': long,
      'lat': lat,
      'isAdmin': isAdmin,
      'delAddresses': delAddresses,
    };
  }
}
