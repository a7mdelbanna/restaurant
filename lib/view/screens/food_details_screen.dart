import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant/controller/bloc/cubit/meals/meals_cubit.dart';
import 'package:restaurant/data/model/topping.dart';
import 'package:restaurant/view/screens/home_screen.dart';

import '../../controller/bloc/blocs/cart/cart_bloc.dart';
import '../../data/model/cart.dart';
import '../../data/model/meal.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/custom_toggle.dart';
import '../widgets/ingredients_dialog.dart';

class FoodDetailsScreen extends StatefulWidget {
  FoodDetailsScreen({Key? key, required this.meal}) : super(key: key);
  final Meal meal;

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen>
    with SingleTickerProviderStateMixin {
  late List<String> sizeToggleLabels;
  List<String> doughTypeToggleLabels = ['Traditional', 'Thin'];
  List<double> prices = [200, 300, 400];
  int _quantity = 1;
  late double _total;
  late TabController _tabController;
  late List<bool> removedIngredientsIndex;
  late List<String> removedIngredients = [];
  late List<bool> extras;
  late List<CustomTopping> selectedToppings = [];
  late MealSize selectedSize;
  @override
  void initState() {
    selectedSize = widget.meal.mealSizes.first;
    _tabController =
        TabController(length: widget.meal.mealIngredients.length, vsync: this);
    _total = widget.meal.mealSizes.first.sizePrice;
    removedIngredientsIndex =
        List.generate(widget.meal.mealIngredients.length, (index) => false);
    extras = List.generate(
        BlocProvider.of<MealsCubit>(context).getToppings().length,
        (index) => false);
    sizeToggleLabels = List.generate(widget.meal.mealSizes.length,
        (index) => '${widget.meal.mealSizes[index].sizeName}');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int selectedIndex = 0;
  List<String> remove = [];
  Cart cart = const Cart();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .3,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          child: Hero(
                            tag: 'ItemImage',
                            child: Container(
                              height: MediaQuery.of(context).size.height * .28,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(widget.meal.mealImageUrl),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 15,
                          child: Container(
                            child: Row(
                              children: [
                                CustomIconButton(
                                  boxShape: BoxShape.circle,
                                  size: 40,
                                  iconColor: Colors.black,
                                  icon: Icons.expand_more,
                                  backgroundColor: Colors.grey[200],
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * .27,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                            ),
                          ),
                        ),

                        // FoodImage(mealImageUrl: widget.meal.mealImageUrl),
                        // FoodDetails(meal: widget.meal),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.meal.mealTitle,
                                softWrap: true,
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                            CustomIconButton(
                                boxShape: BoxShape.circle,
                                icon: Icons.info_outline_rounded,
                                onTap: () {
                                  showDialog(
                                    barrierColor: Colors.transparent,
                                    context: context,
                                    builder: (context) => InfoDialog(
                                      meal: widget.meal,
                                    ),
                                  );
                                },
                                size: 22,
                                iconColor: Colors.black,
                                backgroundColor: Colors.white),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                overflow: TextOverflow.clip,
                                maxLines: 3,
                                widget.meal.mealDescription +
                                    'jgjkguggiufiufiufiufiufufiufiufiufiufifiufiffsdfsdfsffhfghgfhgfjytjytjty e eee wwww qq werewrewrwre ',
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return WillPopScope(
                                        onWillPop: () => Future.value(false),
                                        child: IngredientsDialog(
                                          removedIngredientsIndex: [
                                            ...removedIngredientsIndex
                                          ],
                                          removeTemp: [
                                            ...removedIngredientsIndex
                                          ],
                                          meal: widget.meal,
                                        ),
                                      );
                                    }).then(
                                  (value) {
                                    if (value == null) {
                                      print(value);
                                    } else {
                                      setState(() {
                                        print(value);
                                        removedIngredientsIndex = [...value];
                                      });
                                      remove = List.generate([...value].length,
                                          (index) {
                                        if (removedIngredientsIndex[index]) {
                                          print(widget
                                              .meal.mealIngredients[index]);
                                          print(removedIngredientsIndex[index]);
                                          return widget
                                              .meal.mealIngredients[index];
                                        } else {
                                          return '';
                                        }
                                      }).toList();
                                    }
                                  },
                                );
                              });
                            },
                            child: const Text(
                              'Remove Ingredients',
                              style: TextStyle(color: Colors.orange),
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          children: List.generate(
                              widget.meal.mealIngredients.length, (index) {
                            return Text(
                                style: TextStyle(
                                    color: removedIngredientsIndex[index]
                                        ? Colors.grey
                                        : Colors.black,
                                    decorationStyle: TextDecorationStyle.solid,
                                    decorationColor: Colors.black,
                                    fontSize: 16,
                                    decoration: removedIngredientsIndex[index]
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none),
                                softWrap: true,
                                widget.meal.mealIngredients[index] + ', ');
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Column(
                      children: [
                        const Divider(
                          indent: 70,
                          endIndent: 70,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        //Size Picker
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Size: ',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: CustomToggle(
                                        onTap: (index) {
                                          setState(() {
                                            selectedIndex = index!;
                                            selectedSize = widget
                                                .meal.mealSizes[selectedIndex];
                                            _total = selectedSize.sizePrice;
                                            extras = extras = List.generate(
                                                BlocProvider.of<MealsCubit>(
                                                        context)
                                                    .getToppings()
                                                    .length,
                                                (index) => false);
                                          });
                                        },
                                        width: 85,
                                        initialIndex: selectedIndex,
                                        numberOfSwitches: 3,
                                        toggleLabels: sizeToggleLabels),
                                  ),
                                ),
                              ),
                            ]),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(
                          indent: 70,
                          endIndent: 70,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    childCount: BlocProvider.of<MealsCubit>(context)
                        .getToppings()
                        .length,
                    (context, index) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            extras[index] = !extras[index];
                            extras[index]
                                ? _total += BlocProvider.of<MealsCubit>(context)
                                    .getToppings()[index]
                                    .toppingSizes
                                    .firstWhere((size) =>
                                        size.sizeName == selectedSize.sizeName)
                                    .sizePrice
                                : _total -= BlocProvider.of<MealsCubit>(context)
                                    .getToppings()[index]
                                    .toppingSizes
                                    .firstWhere((size) =>
                                        size.sizeName == selectedSize.sizeName)
                                    .sizePrice;
                            if (extras[index]) {
                              selectedToppings.add(
                                  BlocProvider.of<MealsCubit>(context)
                                      .getToppings()[index]);
                            } else {
                              int rindex = -1;
                              CustomTopping topping =
                                  BlocProvider.of<MealsCubit>(context)
                                      .getToppings()[index];
                              for (CustomTopping customTopping
                                  in selectedToppings) {
                                if (customTopping.toppingTitle ==
                                    topping.toppingTitle) {
                                  rindex =
                                      selectedToppings.indexOf(customTopping);
                                }
                              }
                              rindex == -1
                                  ? {}
                                  : selectedToppings.removeAt(rindex);
                              print(selectedToppings.length);
                            }
                          });
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 2,
                                color: extras[index]
                                    ? Colors.orangeAccent
                                    : Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: extras[index] ? 0 : 4,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(BlocProvider.of<MealsCubit>(context)
                                          .getToppings()[index]
                                          .toppingTitle),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Image(
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            BlocProvider.of<MealsCubit>(context)
                                                .getToppings()[index]
                                                .toppingImageUrl),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        BlocProvider.of<MealsCubit>(context)
                                                .getToppings()[index]
                                                .toppingSizes
                                                .firstWhere((size) =>
                                                    size.sizeName ==
                                                    selectedSize.sizeName)
                                                .sizePrice
                                                .toString() +
                                            ' EGP',
                                      ),
                                    ],
                                  ),
                                ),
                                extras[index]
                                    ? const Positioned(
                                        top: 3,
                                        right: 3,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.lightGreen,
                                          size: 10,
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        const Divider(
                          indent: 70,
                          endIndent: 70,
                        ),
                        //total cost
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Cost: ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Chip(
                              labelPadding: const EdgeInsets.all(5),
                              backgroundColor: Colors.amberAccent,
                              label: Text(
                                _total.toString() + ' EGP',
                                style: const TextStyle(color: Colors.white),
                              ),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 72,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                CartItem cartItem = CartItem(
                                    mealImage: widget.meal.mealImageUrl,
                                    addedToppings: selectedToppings.map((e) {
                                      return AddedTopping(
                                          toppingTitle: e.toppingTitle,
                                          toppingId: e.toppingId,
                                          toppingSizeId: e.toppingSizes
                                              .firstWhere((element) =>
                                                  element.sizeName ==
                                                  selectedSize.sizeName)
                                              .sizeId,
                                          toppingSizeName: e.toppingSizes
                                              .firstWhere((element) =>
                                                  element.sizeName ==
                                                  selectedSize.sizeName)
                                              .sizeName,
                                          toppingSizePrice: e.toppingSizes
                                              .firstWhere((element) =>
                                                  element.sizeName ==
                                                  selectedSize.sizeName)
                                              .sizePrice);
                                    }).toList(),
                                    removedIngredients: [
                                      ...remove
                                          .where((element) => element != '')
                                    ],
                                    tax: 0.0,
                                    offerDis: 0.0,
                                    code: widget.meal.mealId,
                                    userId: '',
                                    sizeId: selectedSize.sizeId,
                                    sizeName: selectedSize.sizeName,
                                    id: widget.meal.mealId,
                                    title: widget.meal.mealTitle,
                                    price: _total,
                                    quantity: 1,
                                    itemTotal: _total,
                                    net: _total);
                                Fluttertoast.showToast(
                                  msg: 'Item added to cart successfully!',
                                  toastLength: Toast.LENGTH_SHORT, // length
                                );
                                BlocProvider.of<CartBloc>(context)
                                    .add(AddProductEvent(cartItem, 'omar'));
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()),
                                    (route) => false);
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    'ADD TO CART',
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

// Row(
//   children: [
//     Container(
//       width: 120,
//       height: 50,
//       padding: EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         color: Colors.amber,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Row(
//         mainAxisAlignment:
//             MainAxisAlignment.spaceEvenly,
//         children: [
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 _quantity -= 1;
//                 _total -= prices[selectedIndex];
//               });
//             },
//             child: Text(
//               '-',
//               style: TextStyle(fontSize: 20),
//             ),
//           ),
//           Container(
//             width: 50,
//             height: 50,
//             padding: EdgeInsets.all(2),
//             decoration: BoxDecoration(
//                 borderRadius:
//                     BorderRadius.circular(15),
//                 shape: BoxShape.rectangle,
//                 color: Colors.white),
//             child: Center(
//               child: Text(
//                 _quantity.toString(),
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 _quantity += 1;
//                 _total += prices[selectedIndex];
//               });
//             },
//             child: Text(
//               '+',
//               style: TextStyle(fontSize: 20),
//             ),
//           ),
//         ],
//       ),
//     ),
//   ],
// ),
// + - items
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// RectangularIconButton(
// icon: Icons.remove,
// onTap: () {
// setState(() {
// _quantity -= 1;
// });
// },
// size: 40,
// iconColor: Colors.black,
// backgroundColor: Colors.white,
// ),
// SizedBox(
// width: 10,
// ),
// Text(
// _quantity.toString(),
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 18),
// ),
// SizedBox(
// width: 10,
// ),
// RectangularIconButton(
// icon: Icons.add,
// onTap: () {
// setState(() {
// _quantity += 1;
// });
// },
// size: 40,
// iconColor: Colors.black,
// backgroundColor: Colors.amberAccent),
// ],
// )

// extras
//Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: List.generate(
//                               widget.meal.toppings.length,
//                               (index) => Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         width: 20,
//                                         height: 20,
//                                         child: Icon(
//                                           widget
//                                               .meal.toppings[index].toppingIcon,
//                                           color: Colors.deepOrange,
//                                           size: 16,
//                                         ),
//                                       ),
//                                       Text(
//                                         widget
//                                             .meal.toppings[index].toppingTitle,
//                                       ),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       Text(
//                                         widget.meal.toppings[index].toppingPrice
//                                                 .toString() +
//                                             ' EGP',
//                                       ),
//                                       SizedBox(
//                                         width: 30,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           RectangularIconButton(
//                                             icon: Icons.remove,
//                                             onTap: () {
//                                               setState(() {
//                                                 _quantity -= 1;
//                                               });
//                                             },
//                                             size: 40,
//                                             iconColor: Colors.black,
//                                             backgroundColor: Colors.white,
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Text(
//                                             _quantity.toString(),
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 18),
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           RectangularIconButton(
//                                               icon: Icons.add,
//                                               onTap: () {
//                                                 setState(() {
//                                                   _quantity += 1;
//                                                 });
//                                               },
//                                               size: 40,
//                                               iconColor: Colors.black,
//                                               backgroundColor: Colors.white),
//                                         ],
//                                       ),
//                                     ],
//                                   )),
//                         ),
