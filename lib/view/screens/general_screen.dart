import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant/controller/bloc/cubit/authintication/auth_cubit.dart';
import 'package:restaurant/data/model/user_model.dart';
import 'package:restaurant/view/screens/login_screen.dart';
import 'package:restaurant/view/screens/profile_screen.dart';

import '../../config/const.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({Key? key}) : super(key: key);

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  @override
  void initState() {
    super.initState();
    user = BlocProvider.of<AuthCubit>(context).getUserData();
  }

  late UserModel user;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).backgroundColor,
      width: MediaQuery.of(context).size.width * .7,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .20,
                color: Colors.orange,
              ),
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * .75,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.paddingSize10,
                  vertical: Sizes.paddingSize20,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .03),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/pizza.jpg'),
                  ),
                  Text(
                    '${user.firstName.toUpperCase()} ${user.lastName.toUpperCase()}',
                    style: TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .005),
                  InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileScreen())),
                    child: ListTile(
                      style: ListTileStyle.drawer,
                      leading: Icon(Icons.person),
                      title: Text(
                        'Profile',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .005),
                  InkWell(
                    child: ListTile(
                      style: ListTileStyle.drawer,
                      leading: Icon(Icons.list_outlined),
                      title: Text(
                        'Order History',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .005),
                  InkWell(
                    child: ListTile(
                      style: ListTileStyle.drawer,
                      leading: Icon(Icons.settings_applications),
                      title: Text(
                        'Settings',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .005),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<AuthCubit>(context).sighOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false);
                    },
                    child: ListTile(
                      style: ListTileStyle.drawer,
                      leading: Icon(Icons.exit_to_app_outlined),
                      title: Text(
                        'Sign Out',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildCard(
      BuildContext context, String title, IconData icon, Function() onTap) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(
        vertical: Sizes.marginSize10,
        horizontal: Sizes.marginSize22,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline3,
        ),
        onTap: onTap,
      ),
    );
  }

  late FToast fToast;

  _showToast(message) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("$message"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );

    // Custom Toast Position
    fToast.showToast(
        child: toast,
        toastDuration: const Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            top: 16.0,
            left: 16.0,
            child: child,
          );
        });
  }

  // showPhoneDialog(BuildContext context, phoneNumber) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return PhoneDialog(phone: phoneNumber, context: context);
  //     },
  //   );
  // }
}
