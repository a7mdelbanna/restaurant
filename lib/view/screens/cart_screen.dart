import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant/controller/bloc/cubit/authintication/auth_cubit.dart';

import '../../controller/bloc/blocs/cart/cart_bloc.dart';
import '../../controller/bloc/blocs/orders/orders_bloc.dart';
import '../../controller/bloc/cubit/network_connectivity/network_connectivity_cubit.dart';
import '../../data/model/cart.dart';
import '../widgets/cart_card.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/dialog.dart';
import '../widgets/text_price.dart';
import 'home_screen.dart';

class CartScreen extends StatefulWidget {
  CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int count = 2;
  Cart cart = Cart();
  bool isStretching = false;
  Widget _buildAppBar(Cart cart) {
    return CustomAppBar(
        appBarFlex: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  '' + ' ${cart.cartItems.length} ' + 'Item in cart',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return TextButton(
                        onPressed: () async {
                          final res = await showDialog(
                            context: context,
                            builder: (context) => DeleteDialog(
                                dialogIcon: Icons.delete,
                                dialogIconColor: Colors.red,
                                acceptText: 'Confirm',
                                cancelText: 'cancel',
                                context: context,
                                dialogTitle: 'Deleting Item',
                                dialogContent:
                                    'Item will be deleted form the cart'),
                          );
                          if (res == true) {
                            context
                                .read<CartBloc>()
                                .add(ClearCartEvent('user.uId!'));
                          }
                        },
                        child: Text('Remove all'));
                  },
                )
              ])
            ],
          ),
        ),
        context: context,
        expandedHeight: 80,
        collapsedHeight: kToolbarHeight,
        customTitle: Text(
          'Cart',
          style: Theme.of(context).textTheme.headline2,
        ));
  }

  Widget _buildCartItems(Cart cart) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: cart.cartItems.length,
        (context, index) {
          return CartItemCard(
            cartItem: cart.cartItems[index],
            index: index,
            // quantity: cart.itemQuantity(cart.cartItems).values.elementAt(index),
          );
        },
      ),
    );
  }

  Widget _buildTotalFooter(Cart cart, BuildContext context3) {
    return SliverToBoxAdapter(
      child: Center(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(left: 2, right: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // BlocProvider.of<AppSettingsCubit>(context).showCartPrices()
                    //     ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextPrice(
                          price: '${cart.itemsTotalString}' + 'LE',
                          text: 'Total:',
                        ),
                        TextPrice(
                          price: '${00.00}' + 'LE',
                          text: 'Tax:',
                        ),
                        const TextPrice(
                            text: 'Del fee:', price: 'Free delivery'),
                        TextPrice(
                            text: 'Net:', price: '${cart.netString}' + 'LE'),
                      ],
                    ),
                    // : const SizedBox(
                    //     height: Height.height20,
                    //   ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<NetworkConnectivityCubit,
                            NetworkConnectivityState>(
                          builder: (context, state) {
                            if (state is NetworkConnectivityInitial ||
                                state is DisconnectedState) {
                              return const Center(
                                child: ElevatedButton(
                                  onPressed: null,
                                  child: Text('NotConnected'),
                                ),
                              );
                            } else {
                              return BlocBuilder<CartBloc, CartState>(
                                builder: (context1, state1) {
                                  return BlocBuilder<OrdersBloc, OrdersState>(
                                    builder: (context2, state2) {
                                      if (state2 is OrdersLoadingState) {
                                        return Center(
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child:
                                                const CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                      } else if (state1 is CartLoadedState &&
                                          state is ConnectedState) {
                                        {
                                          print(state2);
                                          return ConditionalBuilder(
                                              condition:
                                                  state2 != OrdersLoadingState,
                                              builder: (context) => Align(
                                                    alignment: Alignment.center,
                                                    child: Center(
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                minimumSize:
                                                                    Size(300,
                                                                        45)),
                                                        onPressed: () async {
                                                          if (cart.cartItems
                                                              .isEmpty) {
                                                            Fluttertoast
                                                                .showToast(
                                                              msg: 'Empty Cart',
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT, // length
                                                            );
                                                          } else {
                                                            context
                                                                .read<
                                                                    OrdersBloc>()
                                                                .add(
                                                                    AddOrderEvent(
                                                                  delAddress: BlocProvider.of<
                                                                              AuthCubit>(
                                                                          context)
                                                                      .getUserAddress(),
                                                                  totalOfferDis:
                                                                      0.0,
                                                                  totalTax: 0.0,
                                                                  context:
                                                                      context3,
                                                                  userId: BlocProvider.of<
                                                                              AuthCubit>(
                                                                          context)
                                                                      .getUserId(),
                                                                  net: cart
                                                                      .itemsTotal,
                                                                  no: 0,
                                                                  ser: 0,
                                                                  phone: 'user',
                                                                  total: double
                                                                      .parse(cart
                                                                          .itemsTotalString),
                                                                  del: false,
                                                                  dateTime: DateTime
                                                                          .now()
                                                                      .toIso8601String(),
                                                                  items: cart
                                                                      .cartItems,
                                                                  firstName:
                                                                      'user',
                                                                ));
                                                            Future.delayed(
                                                                Duration(
                                                                    seconds:
                                                                        7));
                                                            BlocProvider.of<
                                                                        CartBloc>(
                                                                    context)
                                                                .add(ClearCartEvent(
                                                                    'user.uId!'));
                                                          }
                                                        },
                                                        child: const Text(
                                                          'Check out',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              fallback: (context) =>
                                                  ElevatedButton(
                                                    onPressed: () {},
                                                    child:
                                                        const CircularProgressIndicator(
                                                      color: Colors.white,
                                                    ),
                                                  ));
                                        }
                                      } else {
                                        return ConditionalBuilder(
                                            condition:
                                                state2 != OrdersLoadingState,
                                            builder: (context) => Align(
                                                  alignment: Alignment.center,
                                                  child: Center(
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        minimumSize: Size(
                                                            MediaQuery.of(context)
                                                                        .size
                                                                        .width >=
                                                                    500
                                                                ? 400
                                                                : MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .95,
                                                            40),
                                                      ),
                                                      onPressed: () async {
                                                        if (cart.cartItems
                                                            .isEmpty) {
                                                          Fluttertoast
                                                              .showToast(
                                                            msg: 'Empty Cart',
                                                            toastLength: Toast
                                                                .LENGTH_SHORT, // length
                                                          );
                                                        } else {
                                                          context
                                                              .read<
                                                                  OrdersBloc>()
                                                              .add(
                                                                  AddOrderEvent(
                                                                delAddress: BlocProvider.of<
                                                                            AuthCubit>(
                                                                        context)
                                                                    .getUserAddress(),
                                                                totalOfferDis:
                                                                    0.0,
                                                                totalTax: 0.0,
                                                                context:
                                                                    context3,
                                                                userId: BlocProvider.of<
                                                                            AuthCubit>(
                                                                        context)
                                                                    .getUserId(),
                                                                net: cart
                                                                    .itemsTotal,
                                                                no: 0,
                                                                ser: 0,
                                                                phone: 'user',
                                                                total: double
                                                                    .parse(cart
                                                                        .itemsTotalString),
                                                                del: false,
                                                                dateTime: DateTime
                                                                        .now()
                                                                    .toIso8601String(),
                                                                items: cart
                                                                    .cartItems,
                                                                firstName:
                                                                    'user',
                                                              ));
                                                          Future.delayed(
                                                              Duration(
                                                                  seconds: 7));
                                                          BlocProvider.of<
                                                                      CartBloc>(
                                                                  context)
                                                              .add(ClearCartEvent(
                                                                  'user.uId!'));
                                                        }
                                                      },
                                                      child: const Text(
                                                        'Check out',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            fallback: (context) =>
                                                ElevatedButton(
                                                  onPressed: () {},
                                                  child:
                                                      const CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                ));
                                      }
                                    },
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ],
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

  _buildBlocWidget(BuildContext context3) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CartEmptyState) {
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
              child: Image(
                fit: BoxFit.cover,
                height: 200,
                width: 250,
                image: const AssetImage('assets/images/emptyHistory.jpg'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text('Happiness is...  NOT an empty cart for sure.',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Colors.grey)),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text('Add items to your cart now!',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.grey)),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 40),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const HomeScreen(),
                  ));
                },
                child: const Text(
                  'Menu',
                ),
              ),
            ),
          ]);
        } else if (state is CartLoadedState) {
          return CustomScrollView(
            slivers: [
              _buildAppBar(state.cart),
              _buildCartItems(state.cart),
              _buildTotalFooter(state.cart, context3),
            ],
          );
        } else {
          return Center(
            child: Text('Errrror'),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBlocWidget(context),
      backgroundColor: Colors.white,
    );
  }
}
//SafeArea(
//       child: Scaffold(
//         body: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               floating: true,
//               pinned: true,
//               backgroundColor: Colors.white,
//               centerTitle: true,
//               title: Text(
//                 'Cart',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold),
//               ),
//
//               expandedHeight: 110,
//
//               // bottom: PreferredSize(
//               //     preferredSize: Size(MediaQuery.of(context).size.width, 35),
//               //     child: Padding(
//               //       padding: const EdgeInsets.symmetric(
//               //           horizontal: 15.0, vertical: 8),
//               //       child: Row(
//               //         crossAxisAlignment: CrossAxisAlignment.start,
//               //         children: [
//               //           Row(
//               //             mainAxisAlignment: MainAxisAlignment.start,
//               //             children: [
//               //               Text(
//               //                 '2 Items In cart,',
//               //                 style: TextStyle(
//               //                     fontSize: 16, fontWeight: FontWeight.bold),
//               //               ),
//               //             ],
//               //           ),
//               //           SizedBox(
//               //             height: 5,
//               //           ),
//               //           Row(
//               //             mainAxisAlignment: MainAxisAlignment.start,
//               //             children: [
//               //               Text(
//               //                 '  Total : 5442EGP',
//               //                 style: TextStyle(
//               //                     fontSize: 16, fontWeight: FontWeight.bold),
//               //               ),
//               //             ],
//               //           ),
//               //         ],
//               //       ),
//               //     )),
//               flexibleSpace: FlexibleSpaceBar(
//                 titlePadding: EdgeInsets.only(
//                   top: 50,
//                   left: 20,
//                   bottom: 10,
//                 ),
//                 title: Text(
//                   '${cart.cartItems.length} Items in cart',
//                   style: TextStyle(fontSize: 15, color: Colors.black),
//                 ),
//               ),
//             ),
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 childCount: count,
//                 (context, index) => Dismissible(
//                   direction: DismissDirection.endToStart,
//                   key: UniqueKey(),
//                   onDismissed: (direction) {
//                     setState(() {
//                       count -= 1;
//                     });
//                   },
//                   background: Container(
//                     color: Colors.red,
//                     alignment: Alignment.center,
//                     child: Icon(
//                       Icons.delete,
//                       color: Colors.white,
//                     ),
//                   ),
//                   confirmDismiss: (direction) async {
//                     return showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: Text('Deleting Item!'),
//                         content: Text(
//                             'Are You Sure You want to delete the item from the cart?'),
//                         actions: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Divider(),
//                               GestureDetector(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text('Yes'),
//                                 ),
//                                 onTap: () {
//                                   Navigator.of(context).pop(true);
//                                 },
//                               ),
//                               GestureDetector(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text('No'),
//                                 ),
//                                 onTap: () {
//                                   Navigator.of(context).pop(false);
//                                 },
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   child: Card(
//                     color: Colors.white,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 15.0, vertical: 5),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               CircleAvatar(
//                                 radius: 45,
//                                 foregroundImage:
//                                     AssetImage('assets/images/pizza.jpg'),
//                               ),
//                               SizedBox(
//                                 width: 35,
//                               ),
//                               Expanded(
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                           child: Text(
//                                             softWrap: true,
//                                             'Meal Title',
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'Size',
//                                           style: TextStyle(
//                                               color: Colors.grey, fontSize: 14),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                           child: Text(
//                                             'Ingredients',
//                                             style: TextStyle(
//                                                 color: Colors.grey,
//                                                 fontSize: 14),
//                                             softWrap: true,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                           child: Text(
//                                             softWrap: true,
//                                             '+ AddedExtrassaa',
//                                             style: TextStyle(
//                                                 color: Colors.grey,
//                                                 fontSize: 14),
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                           Divider(
//                             height: 5,
//                             indent: 10,
//                             endIndent: 10,
//                           ),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 5.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Chip(
//                                   labelPadding: EdgeInsets.all(5),
//                                   backgroundColor: Colors.amberAccent,
//                                   label: Text(
//                                     '543 EGP',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                 ),
//                                 // + - items
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     RectangularIconButton(
//                                       icon: Icons.remove,
//                                       onTap: () {
//                                         setState(() {
//                                           _quantity -= 1;
//                                         });
//                                       },
//                                       size: 40,
//                                       iconColor: Colors.black,
//                                       backgroundColor: Colors.white,
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       _quantity.toString(),
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18),
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     RectangularIconButton(
//                                         icon: Icons.add,
//                                         onTap: () {
//                                           setState(() {
//                                             _quantity += 1;
//                                           });
//                                         },
//                                         size: 40,
//                                         iconColor: Colors.black,
//                                         backgroundColor: Colors.white),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   top: 15,
//                   left: 20,
//                   bottom: 3,
//                 ),
//                 child: Column(
//                   children: [
//                     Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//                       Text(
//                         'Add To Order?',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w600),
//                       )
//                     ]),
//                   ],
//                 ),
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                 child: Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: 100,
//                       child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: 4,
//                           itemBuilder: (context, index) {
//                             return Card(
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 14.0, horizontal: 10),
//                                 child: Row(
//                                   children: [
//                                     Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text('Test Item'),
//                                         GestureDetector(
//                                           onTap: () {},
//                                           child: Container(
//                                             padding: EdgeInsets.all(10),
//                                             decoration: BoxDecoration(
//                                               color: Colors.orangeAccent[100],
//                                               borderRadius:
//                                                   BorderRadius.circular(40),
//                                             ),
//                                             child: Text(
//                                               '234EGP',
//                                               style: TextStyle(
//                                                   color: Colors.deepOrange),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       width: 15,
//                                     ),
//                                     CircleAvatar(
//                                       foregroundImage:
//                                           AssetImage('assets/images/pizza.jpg'),
//                                       radius: 30,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: Container(
//                 padding: EdgeInsets.all(10),
//                 color: Colors.white,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 10),
//                             primary: Colors.orangeAccent[200],
//                             maximumSize: Size(175, 40),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             elevation: 2),
//                         onPressed: () {},
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Text(
//                               'Have Promocode?',
//                               style: TextStyle(fontSize: 16),
//                             )
//                           ],
//                         )),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '2 Items',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           '3453EGP',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Delivery',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           'Free',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             padding: EdgeInsets.symmetric(vertical: 10),
//                             primary: Colors.deepOrangeAccent,
//                             maximumSize: Size(250, 50),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             elevation: 2),
//                         onPressed: () {},
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Text(
//                               'Confirm Order ',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             )
//                           ],
//                         )),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.grey[200],
//       ),
//     );
