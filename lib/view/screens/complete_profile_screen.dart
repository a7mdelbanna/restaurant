import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:restaurant/controller/bloc/cubit/authintication/auth_cubit.dart';
import 'package:restaurant/view/screens/location_screen.dart';
import 'package:string_validator/string_validator.dart';

import '../../config/const.dart';
import '../../controller/bloc/cubit/network_connectivity/network_connectivity_cubit.dart';
import '../../theme.dart';
import '../widgets/form_header.dart';
import '../widgets/input_form_field.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CompleteProfileScreenState();
  }
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  late String otpCode;

  late String phoneNumer;

  var formKey = GlobalKey<FormState>();

  String? sumbitted_Code;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdayDateController = TextEditingController();
  final FocusScopeNode _node = FocusScopeNode();
  String long = '';
  DateTime birthDate = DateTime.now();

  String lat = '';
  bool locationSaved = false;
  int currentStep = 0;
  double _headerHeight = 250;

  TextEditingController birthDateController = TextEditingController();

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
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Complete your Profile Info.',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                    ),
                  ),
                  Form(
                    child: Column(children: [
                      GestureDetector(
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(width: 5, color: Colors.white),
                                color: Colors.white,
                                boxShadow: [
                                  const BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 20,
                                    offset: Offset(5, 5),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.person,
                                color: Colors.grey.shade300,
                                size: 80.0,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(75, 75, 0, 0),
                              child: Icon(
                                Icons.add_circle,
                                color: Colors.grey.shade700,
                                size: 35.0,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: CustomFormField(
                            textInputAction: TextInputAction.next,
                            hintText: TextVar.firstNameText,
                            prefixIcon: Icons.person,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return TextVar.name_empty_validation;
                              } else if (isAlpha(val) == false) {
                                return TextVar.name_alpha_validation;
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) {},
                            obscureText: false,
                            textEditingController: firstNameController,
                            textInputType: TextInputType.text),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: CustomFormField(
                            textInputAction: TextInputAction.next,
                            hintText: TextVar.lastNameText,
                            prefixIcon: Icons.person,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return TextVar.name_empty_validation;
                              } else if (isAlpha(val) == false) {
                                return TextVar.name_alpha_validation;
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) {},
                            obscureText: false,
                            textEditingController: lastNameController,
                            textInputType: TextInputType.text),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: CustomFormField(
                            textInputAction: TextInputAction.next,
                            hintText: TextVar.emailText,
                            prefixIcon: Icons.mail,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return TextVar.mail_empty_validation;
                              } else if (val.contains('@') == false ||
                                  val.contains('.') == false) {
                                return TextVar.mail_validation;
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) {},
                            obscureText: false,
                            textEditingController: emailController,
                            textInputType: TextInputType.emailAddress),
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: GestureDetector(
                          onTap: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(1950, 3, 5),
                                maxTime: DateTime.now(),
                                onChanged: (date) {}, onConfirm: (date) {
                              setState(() {
                                birthDate = date;
                                birthDateController.text =
                                    DateFormat('dd/MM/yyyy')
                                        .format(birthDate)
                                        .toString();
                              });
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: CustomFormField(
                              enabled: false,
                              hintText: TextVar.birthdayText,
                              prefixIcon: Icons.cake,
                              validator: (val) {},
                              onSaved: (val) {},
                              obscureText: false,
                              textEditingController: birthDateController,
                              textInputType: TextInputType.emailAddress),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Center(
                        child: Container(
                          child: BlocBuilder<NetworkConnectivityCubit,
                                  NetworkConnectivityState>(
                              builder: (context, state) {
                            if (state is ConnectedState) {
                              return BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  return Center(
                                    child: ConditionalBuilder(
                                        condition:
                                            state != RegisterLoadingState(),
                                        builder: (context) => ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  minimumSize: Size(300, 40)),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    40, 10, 40, 10),
                                                child: Text(
                                                  'Submit',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              onPressed: () {
                                                BlocProvider.of<AuthCubit>(
                                                        context)
                                                    .completePersonalInfo(
                                                        lastName:
                                                            lastNameController
                                                                .text,
                                                        firstName:
                                                            firstNameController
                                                                .text,
                                                        birthdayDate: DateFormat(
                                                                'dd/MM/yyyy')
                                                            .format(birthDate)
                                                            .toString(),
                                                        email: emailController
                                                            .text)
                                                    .then((value) {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LocationScreen()));
                                                });
                                              },
                                            ),
                                        fallback: (contxt) => ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  minimumSize: Size(300, 40)),
                                              child: Padding(
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
                                            )),
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
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
