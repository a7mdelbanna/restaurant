import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant/controller/bloc/cubit/authintication/auth_cubit.dart';
import 'package:string_validator/string_validator.dart';

import '../../config/const.dart';
import '../../controller/bloc/cubit/network_connectivity/network_connectivity_cubit.dart';
import '../../theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/dialog.dart';
import '../widgets/input_form_field.dart';

class UserAddressesScreen extends StatefulWidget {
  const UserAddressesScreen({Key? key}) : super(key: key);

  @override
  State<UserAddressesScreen> createState() => _UserAddressesScreenState();
}

class _UserAddressesScreenState extends State<UserAddressesScreen> {
  late List<String> userAddresses;
  @override
  initState() {
    userAddresses = BlocProvider.of<AuthCubit>(context).getUserDelAddresses();
    super.initState();
  }

  _buildAddressTTile(String address, int index) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.location_on,
            color: Colors.blueGrey,
          ),
          title: Text(address),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => DeleteDialog(
                  acceptText: 'Yes',
                  cancelText: 'cancel',
                  context: context,
                  dialogContent: '$address will be deleted?',
                  dialogTitle: 'Deleting Address!',
                  dialogIcon: Icons.delete,
                  dialogIconColor: Colors.red,
                ),
              ).then((value) async {
                value
                    ? await BlocProvider.of<AuthCubit>(context)
                        .changeUserDelAddresses(address, false, index)
                        .then((value) => Fluttertoast.showToast(
                              msg: 'Address removed'.toUpperCase(),
                              toastLength: Toast.LENGTH_SHORT, // length
                            ))
                    : {};
                setState(() {});
              });
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
        Divider(
          indent: 10,
          endIndent: 10,
        )
      ],
    );
  }

  _buildAddresses() {
    return SliverToBoxAdapter(
      child: Column(children: [
        Column(
          children: List.generate(userAddresses.length,
              (index) => _buildAddressTTile(userAddresses[index], index)),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          CustomAppBar(
              appBarBackgroundColor: Colors.grey[100]!,
              customActions: [
                IconButton(
                  onPressed: () async {
                    showModalBottomSheet(
                        enableDrag: true,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                          ),
                        ),
                        context: context,
                        builder: (context) => Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.grey.shade100),
                              child: AddressBottomSheet(),
                            )).then((value) {
                      setState(() {});
                    });
                  },
                  icon: Icon(Icons.add),
                ),
              ],
              customTitle: Text('Delivery Addresses',
                  style: Theme.of(context).textTheme.headline3),
              context: context,
              expandedHeight: kToolbarHeight,
              collapsedHeight: kToolbarHeight),
          _buildAddresses(),
        ],
      ),
    );
  }
}

class AddressBottomSheet extends StatefulWidget {
  AddressBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddressBottomSheet> createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  final TextEditingController _cityName = TextEditingController();

  final TextEditingController _streetName = TextEditingController();

  final TextEditingController _buildingNo = TextEditingController();

  final TextEditingController _floorNo = TextEditingController();

  final TextEditingController _apartmentNo = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  var textKey = ValueKey(1);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: Sizes.initialChildSize,
      builder: (context, scrollcontroller) => Container(
        color: Colors.white,
        child: SingleChildScrollView(
          controller: scrollcontroller,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.paddingSize12,
              vertical: Sizes.paddingSize22,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                            child: CustomFormField(
                                key: textKey,
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
                                obscureText: false,
                                textEditingController: _cityName,
                                textInputType: TextInputType.text),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                            child: CustomFormField(
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
                                obscureText: false,
                                textEditingController: _streetName,
                                textInputType: TextInputType.text),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                            child: CustomFormField(
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
                                obscureText: false,
                                textEditingController: _buildingNo,
                                textInputType: TextInputType.number),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                            child: CustomFormField(
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
                                obscureText: false,
                                textEditingController: _floorNo,
                                textInputType: TextInputType.number),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                            child: CustomFormField(
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
                                obscureText: false,
                                textEditingController: _apartmentNo,
                                textInputType: TextInputType.number),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            child: BlocBuilder<NetworkConnectivityCubit,
                                    NetworkConnectivityState>(
                                builder: (context, state) {
                              if (state is ConnectedState) {
                                return BlocBuilder<AuthCubit, AuthState>(
                                  builder: (context, state) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(300, 40)),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(40, 10, 40, 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.add_location_alt_outlined,
                                              color: Colors.white70,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "Add Address",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
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
                                    onPressed: null,
                                    child: Text('No connection'));
                              }
                            }),
                          ),
                          const SizedBox(height: 30.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
