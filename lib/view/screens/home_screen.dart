import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/controller/bloc/blocs/orders/orders_bloc.dart';
import 'package:restaurant/controller/bloc/cubit/authintication/auth_cubit.dart';
import 'package:restaurant/data/localservices/cache_local_services.dart';
import 'package:restaurant/view/screens/order_sent_success_screen.dart';
import 'package:restaurant/view/screens/profile_settings_screen.dart';

import '../../controller/bloc/blocs/cart/cart_bloc.dart';
import '../widgets/cart_badge.dart';
import 'cart_screen.dart';
import 'menu_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  bool isinit = false;
  @override
  void didChangeDependencies() async {
    if (!isinit) {
      BlocProvider.of<AuthCubit>(context).getUserId() == ''
          ? {
              await BlocProvider.of<AuthCubit>(context)
                  .getUserDataById(SharedCache.getLastLoggedIn('lastUser')),
              BlocProvider.of<OrdersBloc>(context).add(LoadOrdersEvent(
                  userId: BlocProvider.of<AuthCubit>(context).getUserId()))
            }
          : {
              BlocProvider.of<OrdersBloc>(context).add(LoadOrdersEvent(
                  userId: BlocProvider.of<AuthCubit>(context).getUserId()))
            };
    }
    super.didChangeDependencies();
  }

  var selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              MenuScreen(),
              CartScreen(),
              ProfileSettingsScreen(),
              OrderSuccessScreen(),
            ]),
        bottomNavigationBar: BottomNavigationBar(
            // type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                selectedPage = index;
                _pageController.animateToPage(index,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.bounceInOut);
              });
            },
            currentIndex: selectedPage,
            // iconSize: 20,
            items: [
              BottomNavigationBarItem(
                label: 'Menu',
                icon: Icon(Icons.fastfood_outlined),
              ),
              BottomNavigationBarItem(
                label: 'Cart',
                icon: Container(
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      if (state is CartEmptyState) {
                        return Badge(
                            child: Icon(Icons.shopping_cart_outlined),
                            value: state.cart.cartItems.length);
                      }
                      if (state is CartLoadedState) {
                        return Badge(
                            child: Icon(Icons.shopping_cart_outlined),
                            value: state.cart.cartItems.length);
                      } else {
                        return Icon(Icons.shopping_cart_outlined);
                      }
                    },
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.person_outline),
              ),
              BottomNavigationBarItem(
                label: 'Contacts',
                icon: Icon(Icons.contact_phone),
              ),
            ]),
      ),
    );
  }
}
