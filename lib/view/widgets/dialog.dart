import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:string_validator/string_validator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/const.dart';
import '../../controller/bloc/cubit/authintication/auth_cubit.dart';
import '../../controller/bloc/cubit/network_connectivity/network_connectivity_cubit.dart';
import '../../theme.dart';
import 'input_form_field.dart';
//
// import '../../config/const.dart';

class DeleteDialog extends AlertDialog {
  const DeleteDialog({
    Key? key,
    required this.context,
    required this.dialogTitle,
    required this.dialogContent,
    required this.dialogIcon,
    required this.dialogIconColor,
    required this.acceptText,
    required this.cancelText,
  }) : super(key: key);
  final String dialogTitle;
  final String dialogContent;
  final BuildContext context;

  final String acceptText;
  final String cancelText;

  final IconData dialogIcon;
  final Color dialogIconColor;
  @override
  Color? get backgroundColor => Theme.of(context).dialogTheme.backgroundColor;
  @override
  Widget? get title => Row(
        children: [
          Icon(
            dialogIcon,
            color: dialogIconColor,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            dialogTitle,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      );
  @override
  Widget? get content => Text(
        dialogContent,
        style: Theme.of(context).textTheme.subtitle1,
      );
  @override
  List<Widget> get actions => [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.black26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Divider(
                indent: 10,
                endIndent: 10,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: Text(
                          acceptText,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                    const VerticalDivider(),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: Text(
                          cancelText,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ];
}

class PhoneDialog extends StatelessWidget {
  const PhoneDialog({Key? key, required this.phone, required this.context})
      : super(key: key);
  final String phone;
  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 8.0,
      contentPadding: const EdgeInsets.all(18.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                try {
                  launchUrl(Uri.parse('tel:' + phone));
                } on Exception catch (_) {
                  Fluttertoast.showToast(
                    msg: 'TextVar.tryAgain',
                    toastLength: Toast.LENGTH_SHORT, // length
                  );
                }
              },
              child: Container(
                height: 50.0,
                alignment: Alignment.center,
                child: Text('Call'),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                final Uri smsLaunchUri = Uri(
                  scheme: 'sms',
                  path: phone,
                );
                try {
                  launchUrl(smsLaunchUri);
                } on Exception catch (_) {
                  Fluttertoast.showToast(
                    msg: 'TextVar.tryAgain',
                    toastLength: Toast.LENGTH_SHORT, // length
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Text('Message'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressDialog extends AlertDialog {
  AddressDialog({
    Key? key,
    required this.context,
    required this.dialogTitle,
    required this.dialogContent,
    required this.dialogIcon,
    required this.dialogIconColor,
  }) : super(
          key: key,
        );
  final String dialogTitle;
  final String dialogContent;
  final BuildContext context;

  final IconData dialogIcon;
  final Color dialogIconColor;

  final TextEditingController _cityName = TextEditingController();
  final TextEditingController _streetName = TextEditingController();
  final TextEditingController _buildingNo = TextEditingController();
  final TextEditingController _floorNo = TextEditingController();
  final TextEditingController _apartmentNo = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  Color? get backgroundColor => Theme.of(context).dialogTheme.backgroundColor;

  @override
  List<Widget> get actions => [
        SingleChildScrollView(
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.black26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: CustomFormField(
                            onEditComplete: () {},
                            textInputAction: TextInputAction.next,
                            hintText: 'City Name',
                            prefixIcon: Icons.location_on,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return TextVar.city_empty_validation;
                              } else if (isAlpha(val) == false) {
                                return TextVar.city_numeric_validation;
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) {},
                            obscureText: false,
                            textEditingController: _cityName,
                            textInputType: TextInputType.number),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: CustomFormField(
                            onEditComplete: () {},
                            textInputAction: TextInputAction.next,
                            hintText: 'Street',
                            prefixIcon: Icons.fork_right,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return TextVar.street_empty_validation;
                              } else if (isAlpha(val) == false) {
                                return TextVar.street_aplha_validation;
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) {},
                            obscureText: false,
                            textEditingController: _streetName,
                            textInputType: TextInputType.text),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: CustomFormField(
                            onEditComplete: () {},
                            textInputAction: TextInputAction.next,
                            hintText: 'Building no',
                            prefixIcon: Icons.location_city,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return TextVar.building_empty_validation;
                              } else if (isNumeric(val) == false) {
                                return TextVar.building_numeric_validation;
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) {},
                            obscureText: false,
                            textEditingController: _buildingNo,
                            textInputType: TextInputType.text),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: CustomFormField(
                            onEditComplete: () {},
                            textInputAction: TextInputAction.next,
                            hintText: 'Floor no',
                            prefixIcon: Icons.location_city_outlined,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return TextVar.floor_empty_validation;
                              } else if (isNumeric(val) == false) {
                                return TextVar.floor_numeric_validation;
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) {},
                            obscureText: false,
                            textEditingController: _floorNo,
                            textInputType: TextInputType.text),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: CustomFormField(
                            onEditComplete: () {},
                            textInputAction: TextInputAction.next,
                            hintText: 'Apartment number',
                            prefixIcon: Icons.balcony,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return TextVar.apartment_empty_validation;
                              } else if (isNumeric(val) == false) {
                                return TextVar.apartment_numeric_validation;
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) {},
                            obscureText: false,
                            textEditingController: _apartmentNo,
                            textInputType: TextInputType.text),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        child: BlocBuilder<NetworkConnectivityCubit,
                                NetworkConnectivityState>(
                            builder: (context, state) {
                          if (state is ConnectedState) {
                            return BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(300, 35)),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      "Add Address",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      String address =
                                          '${_cityName.text}, ${_streetName.text},building: ${_buildingNo.text},floor: ${_floorNo.text}, apartment: ${_apartmentNo.text}';

                                      BlocProvider.of<AuthCubit>(context)
                                          .changeUserDelAddresses(
                                              address,
                                              true,
                                              BlocProvider.of<AuthCubit>(
                                                          context)
                                                      .getUserDelAddresses()
                                                      .length +
                                                  1)
                                          .then((value) =>
                                              Navigator.pop(context, true));
                                    }
                                  },
                                );
                              },
                            );
                          } else {
                            return ElevatedButton(
                                onPressed: null, child: Text('No connection'));
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ];
}

class DelRatingDialog extends StatelessWidget {
  const DelRatingDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: Text(
        'How was your order?',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 23.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      message: Text(
        'Tap a star to set your rating,\n Add comment below if you want.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15.sp),
      ),
      // encourage your user to leave a high rating?
      starSize: 35.w,
      // your app's logo?
      showCloseButton: true, enableComment: true,
      submitButtonText: 'Submit',
      commentHint: 'Add comment',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');

        // TODO: add your own logic
        if (response.rating < 3.0) {
        } else {}
      },
    );
  }
}
