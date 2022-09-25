import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/controller/bloc/cubit/network_connectivity/network_connectivity_cubit.dart';
import 'package:string_validator/string_validator.dart';

import '../../config/const.dart';
import '../../controller/bloc/cubit/authintication/auth_cubit.dart';
import '../../theme.dart';
import '../widgets/form_header.dart';
import '../widgets/input_form_field.dart';
import 'forget_password_screen.dart';
import 'signup_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  _buildFormText() {
    return Column(
      children: const [
        Text(
          'Welcome',
          style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
        ),
        Text(
          'Sign in into your account',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  _buildForm() {
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
                        } else if (isLength(val, 11) == false) {
                          return TextVar.phone_length_validation;
                        } else {
                          return null;
                        }
                      },
                      onSaved: (val) {},
                      obscureText: false,
                      textEditingController: _phoneController,
                      textInputType: TextInputType.number),
                ),
                SizedBox(height: 30.0),

                Center(
                  child: Container(
                    child: BlocBuilder<NetworkConnectivityCubit,
                        NetworkConnectivityState>(builder: (context, state) {
                      if (state is ConnectedState) {
                        return BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return ConditionalBuilder(
                              condition: state != LoginLoadingState(),
                              builder: (context) => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(300, 40)),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text(
                                    'SIGN IN',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await BlocProvider.of<AuthCubit>(context)
                                        .login(
                                      context: context,
                                      phone: _phoneController.text,
                                    );
                                  } //After successful login we will redirect to profile page. Let's create profile page now
                                },
                              ),
                              fallback: (context) => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(300, 40)),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  //After successful login we will redirect to profile page. Let's create profile page now
                                },
                              ),
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
                    TextSpan(text: "Don\'t have an account? "),
                    TextSpan(
                      text: 'Create',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationPage()));
                        },
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor),
                    ),
                  ])),
                ),
              ],
            ));
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
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true,
                  Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    children: [
                      _buildFormText(),
                      SizedBox(height: 20.0),
                      _buildForm(),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
