import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/view/screens/profile_screen.dart';
import 'package:restaurant/view/screens/user_addresses.dart';
import 'package:restaurant/view/widgets/custom_app_bar.dart';

import '../../controller/bloc/cubit/authintication/auth_cubit.dart';
import '../../data/model/user_model.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/discount_card.dart';
import 'orders_history_screen.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  late UserModel user;
  @override
  initState() {
    user = BlocProvider.of<AuthCubit>(context).getUserData();
    super.initState();
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
  }

  _buildBodyScreen(context) {
    return SliverToBoxAdapter(
      child: Theme(
        data: Theme.of(context).copyWith(
            cardTheme: Theme.of(context).cardTheme.copyWith(
                  elevation: 1,
                )),
        child: Column(
          children: [
            Column(children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Card(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .44,
                          height: 140,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Bonus Amount',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      '326 ',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      const Positioned(
                        bottom: -3,
                        left: -3,
                        child: Image(
                          width: 100,
                          height: 80,
                          image: AssetImage('assets/images/bonus.png'),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const UserAddressesScreen()));
                        },
                        child: Card(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width * .44,
                            height: 60,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Addresses',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const OrderScreen(),
                          ));
                        },
                        child: Card(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width * .44,
                            height: 60,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Order History',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: Colors.white,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Latest offer ',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const DiscountCard(
                      image: 'assets/images/shawarma2.jpg',
                      title: 'Buy 5 get 1 for free',
                      subtitle: 'till 20,october',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'promo code:',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'No codes available right now.',
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          CustomAppBar(
              appBarBackgroundColor: Colors.grey[100]!,
              customTitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user.firstName,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    CustomIconButton(
                      boxShape: BoxShape.circle,
                      icon: Icons.settings,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ),
                        );
                      },
                      size: 30,
                      iconColor: Colors.blueGrey,
                      backgroundColor: Colors.grey[100],
                    )
                  ],
                ),
              ),
              context: context,
              expandedHeight: kToolbarHeight,
              collapsedHeight: kToolbarHeight),
          _buildBodyScreen(context),
        ],
      ),
    );
  }
}
