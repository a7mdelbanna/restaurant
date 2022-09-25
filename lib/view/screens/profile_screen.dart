import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/controller/bloc/cubit/authintication/auth_cubit.dart';

import '../../data/model/user_model.dart';
import '../widgets/dialog.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel user;
  @override
  initState() {
    user = BlocProvider.of<AuthCubit>(context).getUserData();
    super.initState();
  }

  _buildUserDataCol(String key, String val) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(key, style: Theme.of(context).textTheme.bodyText1),
        SizedBox(
          height: 14,
        ),
        Text(val, style: Theme.of(context).textTheme.subtitle1),
        Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.deepOrangeAccent),
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 30,
              ),
              Text('Personal information',
                  style: Theme.of(context).textTheme.headline2),
              SizedBox(
                height: 25,
              ),
              _buildUserDataCol(
                'Name',
                user.firstName + ' ' + user.lastName,
              ),
              _buildUserDataCol('Phone Number', user.phone),
              _buildUserDataCol('E-mail', user.email),
              _buildUserDataCol('Birthday Date:', user.birthdayDate),
              _buildUserDataCol('Address:', user.delAddresses!.first ?? ''),
              SizedBox(
                height: 25,
              ),
              Text('Settings', style: Theme.of(context).textTheme.headline3),
              Column(
                children: [
                  TextButton(
                    child: Text('Sign out'),
                    onPressed: () {},
                  ),
                  Text(
                      'Note: The next time you open the app u will be asked for your phone number.',
                      style: Theme.of(context).textTheme.subtitle1)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  TextButton(
                    child: Text('Delete Account'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => DeleteDialog(
                          acceptText: 'Yes',
                          cancelText: 'cancel',
                          context: context,
                          dialogContent:
                              'Are you sure you want to delete your account?',
                          dialogTitle: 'Deleting Account!',
                          dialogIcon: Icons.delete,
                          dialogIconColor: Colors.red,
                        ),
                      ).then((value) {
                        value ? {} : {};
                      });
                    },
                  ),
                  Text(
                      'Note: All your information will be deleted including personal information, order history and your bonus.',
                      style: Theme.of(context).textTheme.subtitle1),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
//Stack(
//             children: [
//               Container(
//                 height: 150,
//                 child: HeaderWidget(150, false, Icons.house_rounded),
//               ),
//               Container(
//                 alignment: Alignment.center,
//                 margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
//                 padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 40,
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                         border: Border.all(width: 5, color: Colors.white),
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 20,
//                             offset: const Offset(5, 5),
//                           ),
//                         ],
//                       ),
//                       child: Icon(
//                         Icons.person,
//                         size: 80,
//                         color: Colors.grey.shade300,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       user.firstName + '' + user.lastName ?? '',
//                       style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                       child: Column(
//                         children: <Widget>[
//                           Container(
//                             padding:
//                                 const EdgeInsets.only(left: 8.0, bottom: 4.0),
//                             alignment: Alignment.topLeft,
//                             child: Text(
//                               "Personal Info",
//                               style: TextStyle(
//                                 color: Colors.black87,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 16,
//                               ),
//                               textAlign: TextAlign.left,
//                             ),
//                           ),
//                           Card(
//                             child: Container(
//                               alignment: Alignment.topLeft,
//                               padding: EdgeInsets.all(15),
//                               child: Column(
//                                 children: <Widget>[
//                                   Column(
//                                     children: <Widget>[
//                                       ...ListTile.divideTiles(
//                                         color: Colors.grey,
//                                         tiles: [
//                                           ListTile(
//                                             contentPadding:
//                                                 EdgeInsets.symmetric(
//                                                     horizontal: 12,
//                                                     vertical: 4),
//                                             leading: Icon(Icons.location_on),
//                                             title: Text("Location"),
//                                             subtitle: Text(user.cityName),
//                                           ),
//                                           ListTile(
//                                             leading: Icon(Icons.email),
//                                             title: Text("Email"),
//                                             subtitle: Text(user.email),
//                                           ),
//                                           ListTile(
//                                             leading: Icon(Icons.phone),
//                                             title: Text("Phone"),
//                                             subtitle: Text(user.phone),
//                                           ),
//                                           ListTile(
//                                             leading: Icon(Icons.cake),
//                                             title: Text("Birthday:"),
//                                             subtitle: Text('20/4/1990'),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           )
