import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:string_validator/string_validator.dart';

import '../../config/const.dart';
import '../../controller/bloc/cubit/authintication/auth_cubit.dart';
import '../../controller/bloc/cubit/network_connectivity/network_connectivity_cubit.dart';
import '../../theme.dart';
import '../widgets/form_header.dart';
import '../widgets/input_form_field.dart';
import 'complete_profile_screen.dart';
import 'login_screen.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  late String otpCode;

  late String phoneNumer;

  var formKey = GlobalKey<FormState>();

  String? sumbitted_Code;

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController otpController = TextEditingController();

  final FocusScopeNode _node = FocusScopeNode();

  double _headerHeight = 200;
  _buildHeaderText() {
    return Column(
      children: const [
        Text(
          'SIGN UP',
          style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Create account to complete your order.',
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  _buildSignUpForm() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                child: CustomFormField(
                    textInputAction: TextInputAction.next,
                    hintText: TextVar.phone,
                    prefixIcon: Icons.phone,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return TextVar.phone_empty_validation;
                      } else if (isNumeric(val) == false) {
                        return TextVar.phone_numeric_validation;
                      } else if (val.startsWith('01') == false) {
                        return TextVar.phone_startsWith_validation;
                      } else if (isLength(val, 11) == false) {
                        return TextVar.phone_length_validation;
                      } else {
                        return null;
                      }
                    },
                    obscureText: false,
                    textEditingController: phoneController,
                    textInputType: TextInputType.number),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: Container(
                  child: BlocBuilder<NetworkConnectivityCubit,
                      NetworkConnectivityState>(builder: (context, state) {
                    if (state is ConnectedState) {
                      return BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(300, 40)),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<AuthCubit>(context)
                                    .register(phone: phoneController.text);
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        showOTPDialog(context));
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
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                //child: Text('Don\'t have an account? Create'),
                child: Text.rich(TextSpan(children: [
                  TextSpan(text: "Have an account already? "),
                  TextSpan(
                    text: 'Sign in',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor),
                  ),
                ])),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(
                  _headerHeight, false, Icons.person_add_alt_1_rounded),
            ),
            SafeArea(
              child: Container(
                margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    _buildHeaderText(),
                    _buildSignUpForm(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String otp = '';
  showOTPDialog(context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(top: 10, left: 10, bottom: 0),
      alignment: Alignment.center,
      elevation: 10,
      backgroundColor: Colors.white,
      title: Center(
        child: Text(
          'Phone Verification',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actions: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Enter received OTP below:',
            style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 5),
        _buildOTPFORM(context),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: Size(250, 40)),
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context)
                        .completeSignIn(
                      otp: otp,
                      phone: phoneController.text,
                    )
                        .then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CompleteProfileScreen()));
                    }).catchError((error) {
                      Fluttertoast.showToast(
                          msg: 'Error verifying phone',
                          toastLength: Toast.LENGTH_SHORT);
                    });
                  },
                  child: Text('SUBMIT'));
              // ConditionalBuilder(
              //   condition: state != RegisterLoadingState(),
              //   builder: (context) => Center(
              //         child:
              //       ),
              //   fallback: (context) => Center(
              //         child: ElevatedButton(
              //           style: ElevatedButton.styleFrom(
              //               minimumSize: Size(250, 40)),
              //           onPressed: () {},
              //           child: Center(
              //             child: CircularProgressIndicator(color: Colors.white),
              //           ),
              //         ),
              //       ));
            },
          ),
        ),
      ],
    );
  }

  _buildOTPFORM(context) {
    return PinCodeTextField(
      autoDisposeControllers: false,
      autoFocus: true,
      autoDismissKeyboard: true,
      keyboardType: TextInputType.number,
      appContext: context,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        inactiveColor: Colors.grey.shade400,
        selectedColor: Colors.grey.shade200,
        inactiveFillColor: Colors.grey.shade400,
        selectedFillColor: Colors.grey.shade200,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        activeColor: Colors.grey.shade50,
      ),
      cursorColor: Colors.black,
      enablePinAutofill: true,
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.white,
      enableActiveFill: true,
      controller: otpController,
      onCompleted: (v) {
        otp = v;
      },
      onChanged: (value) {
        print(value);
        setState(() {
          otp = value;
        });
      },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );
  }
}
