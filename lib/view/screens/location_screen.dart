import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/view/screens/home_screen.dart';
import 'package:string_validator/string_validator.dart';

import '../../config/const.dart';
import '../../controller/bloc/cubit/authintication/auth_cubit.dart';
import '../../controller/bloc/cubit/network_connectivity/network_connectivity_cubit.dart';
import '../../theme.dart';
import '../widgets/form_header.dart';
import '../widgets/input_form_field.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({Key? key}) : super(key: key);
  var _formKey = GlobalKey<FormState>();

  final TextEditingController cityNameController = TextEditingController();

  final TextEditingController buildingNoController = TextEditingController();

  final TextEditingController streetController = TextEditingController();

  final TextEditingController floorNoController = TextEditingController();

  final TextEditingController apartmentNoController = TextEditingController();
  String long = '';
  String lat = '';
  final FocusScopeNode _node = FocusScopeNode();

  double _headerHeight = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(
                  _headerHeight, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Complete your address info.',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: CustomFormField(
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
                              textEditingController: cityNameController,
                              textInputType: TextInputType.text),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
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
                              textEditingController: streetController,
                              textInputType: TextInputType.text),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
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
                              onSaved: (val) {},
                              obscureText: false,
                              textEditingController: buildingNoController,
                              textInputType: TextInputType.text),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
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
                              textEditingController: floorNoController,
                              textInputType: TextInputType.text),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
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
                              textEditingController: apartmentNoController,
                              textInputType: TextInputType.text),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          child: BlocBuilder<NetworkConnectivityCubit,
                                  NetworkConnectivityState>(
                              builder: (context, state) {
                            if (state is ConnectedState) {
                              return BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  return ConditionalBuilder(
                                      condition:
                                          state != RegisterLoadingState(),
                                      builder: (context) => ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                minimumSize: Size(300, 40)),
                                            child: const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  40, 10, 40, 10),
                                              child: Text(
                                                "Complete Address",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                BlocProvider.of<AuthCubit>(
                                                        context)
                                                    .completeAddressInfo(
                                                        cityName:
                                                            cityNameController
                                                                .text,
                                                        street: streetController
                                                            .text,
                                                        buildingNo:
                                                            buildingNoController
                                                                .text,
                                                        floorNo:
                                                            floorNoController
                                                                .text,
                                                        apartmentNo:
                                                            apartmentNoController
                                                                .text,
                                                        lat: lat,
                                                        long: long)
                                                    .then((value) {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomeScreen()));
                                                });
                                              }
                                            },
                                          ),
                                      fallback: (context) => ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                minimumSize: Size(300, 40)),
                                            child: const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  40, 10, 40, 10),
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            onPressed: () {},
                                          ));
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
          ],
        ),
      ),
    );
  }
}
