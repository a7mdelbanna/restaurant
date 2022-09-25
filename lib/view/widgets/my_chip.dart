import 'package:collapsible/collapsible.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/data/model/meal.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../data/model/category.dart';
import '../../data/model/dummy_meals.dart';
import 'sliver_sub_header.dart';
import 'story_button.dart';
import 'toggle_switch.dart';

class MyChip extends StatefulWidget {
  MyChip({
    Key? key,
  }) : super(key: key);

  @override
  State<MyChip> createState() => _MyChipState();
}

class _MyChipState extends State<MyChip> with SingleTickerProviderStateMixin {
  var selectedIndex;
  var selectedCategory = 0;

  var selectedTab = 0;
  var isPressed = false;
  var searchedText;

  final ItemScrollController itemScrollController = ItemScrollController();
  final itemPositionsListener = ItemPositionsListener.create();

  Meals myMeals = Meals();
  var selectedChipIndex = 0;
  var isPressed2 = false;
  var isSelected = false;
  var searchedText2;
  int isInit = 0;

  Categories myCategories = Categories();
  var selectedChipTitle;
  int categoryIndex(int index) {
    int categoryIndex = 0;
    myMeals.categoryIndex(index);
    return categoryIndex;
  }

  int selectedCategoryItemsIndex(String categoryTitle) {
    int index;
    switch (categoryTitle) {
      case "Pizza":
        {
          index = myMeals.categoryFirstIndex('Pizza');
        }
        break;

      case "Burger":
        {
          index = myMeals.categoryFirstIndex('Burger');
        }
        break;

      case "Pasta":
        {
          index = myMeals.categoryFirstIndex('Pasta');
        }
        break;

      case "Shawarma":
        {
          index = myMeals.categoryFirstIndex('Shawarma');
        }
        break;
      case "Fajita":
        {
          index = myMeals.categoryFirstIndex('Fajita');
        }
        break;

      default:
        {
          index = 0;
        }
        break;
    }

    return index;
  }

  var selectedPage = 0;
  @override
  bool isCollapsed = false;
  Widget showSearchField() {
    return Expanded(
      child: ListTile(
        trailing: IconButton(
          onPressed: () {
            setState(() {
              isPressed = !isPressed;
            });
          },
          icon: const Icon(Icons.close),
        ),
        leading: IconButton(
          icon: const Icon(Icons.search_outlined),
          onPressed: () {
            print(searchedText);
            setState(() {
              isPressed = !isPressed;
            });
          },
        ),
        title: TextField(
          onChanged: (val) {
            setState(() {
              searchedText = val;
            });
          },
          decoration: const InputDecoration(
            hintText: 'Pizza',
            hintStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
            border: InputBorder.none,
          ),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  toggleCollapse() {
    setState(() {
      isCollapsed = true;
    });
  }

  late TabController _tabController;
  late PageController _pageController = PageController(initialPage: 0);
  List<int> indices = [0];
  ScrollPhysics togglePhysics() {
    if (indices.isEmpty == true && indices.length < 4) {
      return ScrollPhysics();
    } else
      return NeverScrollableScrollPhysics();
  }

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  List<Widget> buildItemList(List<Meal> categoryItems) {
    List<Widget> list = [
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: categoryItems
            .map((e) => Container(
                  height: 180,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: 230,
                      height: 170,
                      child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 70,
                                backgroundImage: NetworkImage(
                                    'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmVlZiUyMGJ1cmdlcnxlbnwwfHwwfHw%3D&w=1000&q=80'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(e.mealTitle),
                                  Text('Item'),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.orangeAccent[100],
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Text(
                                        e.mealSizes.first.sizePrice.toString(),
                                        style:
                                            TextStyle(color: Colors.deepOrange),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                ))
            .toList(),
      )
    ];

    return list;
  }

  Widget buildCategoryList(Category category) {
    Category myCategory = category;
    return Column(children: buildItemList(category.categoryMeals));
  }

  List<Widget> buildCategoryTabs() {
    List<Widget> tabs = myCategories.categories
        .map((e) => Tab(
              child: Text(e.categoryTitle),
            ))
        .toList();
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    selectedChipTitle = myCategories.categories.first.categoryTitle;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(10),
            child: CustomScrollView(
              slivers: [
                SliverSubHeader(
                  widget: Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isCollapsed = !isCollapsed;
                              print(isCollapsed);
                            });
                          },
                          child: Row(
                            children: [
                              Text('Omar'),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.expand_more_outlined),
                              ),
                            ],
                          ),
                        ),
                        isPressed
                            ? showSearchField()
                            : IconButton(
                                icon: const Icon(Icons.search_outlined),
                                onPressed: () {
                                  setState(() {
                                    isPressed = !isPressed;
                                  });
// showSearch(
//     delegate: MySearchDelegate(), context: context);
                                },
                              ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Collapsible(
                      axis: CollapsibleAxis.horizontal,
                      collapsed: isCollapsed,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Toggle(
                            location: 'Giza',
                          ),
                          MyStories(),
                          const Text(
                            'Order Offers',
                          ),
                          Container(
                            width: 400,
                            height: 100,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (context, index) => Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      elevation: 1,
                                      child: Container(
                                        width: 230,
                                        height: 100,
                                        child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: 85,
                                                  width: 85,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            85),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmVlZiUyMGJ1cmdlcnxlbnwwfHwwfHw%3D&w=1000&q=80'),
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(myCategories
                                                        .categories[index]
                                                        .categoryTitle),
                                                    GestureDetector(
                                                      onTap: () {},
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                                  .orangeAccent[
                                                              100],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                        ),
                                                        child: Text(
                                                          '200 EGP',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .deepOrange),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            )),
                                      ),
                                    )),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                SliverSubHeader(
                  widget: Container(
                      color: Colors.white,
                      child: TabBar(
                        tabs: buildCategoryTabs(),
                        controller: _tabController,
                      )),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        height: 800,
                        child: PageView(
                          scrollDirection: Axis.vertical,
                          controller: _pageController,
                          children: myCategories.categories
                              .map((e) => buildCategoryList(e))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// CustomScrollView(
//               slivers: [
//                 SliverSubHeader(
//                   widget: Container(
//                     color: Colors.white,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             setState(() {
//                               isCollapsed = !isCollapsed;
//                               print(isCollapsed);
//                             });
//                           },
//                           child: Row(
//                             children: [
//                               Text('Omar'),
//                               IconButton(
//                                 onPressed: () {},
//                                 icon: Icon(Icons.expand_more_outlined),
//                               ),
//                             ],
//                           ),
//                         ),
//                         isPressed
//                             ? showSearchField()
//                             : IconButton(
//                                 icon: const Icon(Icons.search_outlined),
//                                 onPressed: () {
//                                   setState(() {
//                                     isPressed = !isPressed;
//                                   });
// // showSearch(
// //     delegate: MySearchDelegate(), context: context);
//                                 },
//                               ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SliverList(
//                   delegate: SliverChildListDelegate([
//                     Collapsible(
//                       axis: CollapsibleAxis.horizontal,
//                       collapsed: isCollapsed,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Toggle(),
//                           MyStories(),
//                           const Text(
//                             'Order Offers',
//                           ),
//                           Container(
//                             width: 400,
//                             height: 100,
//                             child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: 3,
//                                 itemBuilder: (context, index) => Card(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(20),
//                                       ),
//                                       elevation: 1,
//                                       child: Container(
//                                         width: 230,
//                                         height: 100,
//                                         child: Padding(
//                                             padding: const EdgeInsets.all(10),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Container(
//                                                   height: 85,
//                                                   width: 85,
//                                                   decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             85),
//                                                     image: DecorationImage(
//                                                       fit: BoxFit.cover,
//                                                       image: NetworkImage(
//                                                           'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmVlZiUyMGJ1cmdlcnxlbnwwfHwwfHw%3D&w=1000&q=80'),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     Text(myCategories
//                                                         .categories[index]
//                                                         .categoryTitle),
//                                                     GestureDetector(
//                                                       onTap: () {},
//                                                       child: Container(
//                                                         padding:
//                                                             EdgeInsets.all(10),
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           color: Colors
//                                                                   .orangeAccent[
//                                                               100],
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(40),
//                                                         ),
//                                                         child: Text(
//                                                           '200 EGP',
//                                                           style: TextStyle(
//                                                               color: Colors
//                                                                   .deepOrange),
//                                                         ),
//                                                       ),
//                                                     )
//                                                   ],
//                                                 )
//                                               ],
//                                             )),
//                                       ),
//                                     )),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ]),
//                 ),
//                 SliverSubHeader(
//                   widget: Container(
//                     color: Colors.white,
//                     child: TabBar(
//                       isScrollable: true,
//                       controller: _tabController,
//                       tabs: myCategories.categories
//                           .map(
//                             (e) => Padding(
//                               padding: EdgeInsets.all(5),
//                               child: ChoiceChip(
//                                 labelPadding: EdgeInsets.all(5),
//                                 avatar: Icon(Icons.fastfood_outlined,
//                                     color: Colors.red),
//                                 selectedColor: Colors.orange[200],
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 labelStyle: TextStyle(color: Colors.deepOrange),
//
//                                 backgroundColor: Colors.orangeAccent,
//                                 onSelected: (selected) {
//                                   setState(() {
//                                     isSelected = selected;
//                                     // selectedChipIndex = index;
//
//                                     // itemScrollController.scrollTo(
//                                     //     index: selectedCategoryItemsIndex(
//                                     //         myCategories.categories[index]
//                                     //             .categoryTitle),
//                                     //     duration: Duration(seconds: 2),
//                                     //     curve: Curves.easeInOutCubic);
// // _categoryPageController.animateToPage(index,
// //     duration: Duration(microseconds: 500),
// //     curve: Curves.easeIn);
//                                   });
//                                 },
//                                 // selected: index == selectedChipIndex
//                                 //     ? true
//                                 //     : false,
//                                 selected: true,
//                                 label: Text(e.categoryTitle),
//                               ),
//                             ),
//                           )
//                           .toList() as List<Widget>,
//                     ),
//                   ),
//                 ),
//                 SliverList(
//                   delegate: SliverChildListDelegate(
//                     [
//                       Expanded(
//                         child: TabBarView(
//                           dragStartBehavior: DragStartBehavior.down,
//                           physics: ScrollPhysics(),
//                           controller: _tabController,
//                           children: [...buildCategoryList()],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

// ChoiceChip(
// labelPadding: EdgeInsets.all(5),
// avatar: Icon(Icons.fastfood_outlined,
// color:
// e.categoryTitle == selectedChipTitle
// ? Colors.red
//     : Colors.black),
// selectedColor:
// e.categoryTitle == selectedChipTitle
// ? Colors.orange[200]
// : Colors.grey,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(10),
// ),
// labelStyle: TextStyle(
// color:
// e.categoryTitle == selectedChipTitle
// ? Colors.deepOrange
//     : Colors.black),
// onSelected: (selected) {
// setState(() {
// selectedChipTitle = e.categoryTitle;
// isSelected = selected;
// });
// },
// selected: e.categoryTitle == selectedChipTitle
// ? true
// : false,
// label: Text(e.categoryTitle),
// )
//////////////////
// vertical scrollable tabview
// VerticalScrollableTabView(
// verticalScrollPosition: VerticalScrollPosition.begin,
// eachItemChild: (object, index) {
// return buildCategoryList(object);
// },
// listItemData: myCategories.categories,
// tabController: _tabController,
// slivers: [
// SliverSubHeader(
// widget: Container(
// color: Colors.white,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// InkWell(
// onTap: () {
// setState(() {
// isCollapsed = !isCollapsed;
// print(isCollapsed);
// });
// },
// child: Row(
// children: [
// Text('Omar'),
// IconButton(
// onPressed: () {},
// icon: Icon(Icons.expand_more_outlined),
// ),
// ],
// ),
// ),
// isPressed
// ? showSearchField()
//     : IconButton(
// icon: const Icon(Icons.search_outlined),
// onPressed: () {
// setState(() {
// isPressed = !isPressed;
// });
// // showSearch(
// //     delegate: MySearchDelegate(), context: context);
// },
// ),
// ],
// ),
// ),
// ),
// SliverList(
// delegate: SliverChildListDelegate([
// Collapsible(
// axis: CollapsibleAxis.horizontal,
// collapsed: isCollapsed,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// const Toggle(),
// MyStories(),
// const Text(
// 'Order Offers',
// ),
// Container(
// width: 400,
// height: 100,
// child: ListView.builder(
// scrollDirection: Axis.horizontal,
// itemCount: 3,
// itemBuilder: (context, index) => Card(
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(20),
// ),
// elevation: 1,
// child: Container(
// width: 230,
// height: 100,
// child: Padding(
// padding: const EdgeInsets.all(10),
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment
//     .spaceBetween,
// children: [
// Container(
// height: 85,
// width: 85,
// decoration: BoxDecoration(
// borderRadius:
// BorderRadius.circular(
// 85),
// image: DecorationImage(
// fit: BoxFit.cover,
// image: NetworkImage(
// 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmVlZiUyMGJ1cmdlcnxlbnwwfHwwfHw%3D&w=1000&q=80'),
// ),
// ),
// ),
// Column(
// mainAxisAlignment:
// MainAxisAlignment
//     .spaceBetween,
// children: [
// Text(myCategories
//     .categories[index]
// .categoryTitle),
// GestureDetector(
// onTap: () {},
// child: Container(
// padding:
// EdgeInsets.all(10),
// decoration:
// BoxDecoration(
// color: Colors
//     .orangeAccent[
// 100],
// borderRadius:
// BorderRadius
//     .circular(40),
// ),
// child: Text(
// '200 EGP',
// style: TextStyle(
// color: Colors
//     .deepOrange),
// ),
// ),
// )
// ],
// )
// ],
// )),
// ),
// )),
// ),
// ],
// ),
// ),
// ]),
// ),
// SliverSubHeader(
// widget: Container(
// height: 80,
// width: double.infinity,
// color: Colors.white,
// child: TabBar(
// onTap: (value) {
// selectedChipIndex = value;
// print(value);
// setState(() {
// _tabController.index = value;
// });
// },
// isScrollable: true,
// controller: _tabController,
// tabs: [
// Tab(
// child: Text('1',style:TextStyle(color: Colors.black),),
// ),
// Tab(
// child: Text('2',style:TextStyle(color: Colors.black),),
// ),
// Tab(
// child: Text('3',style:TextStyle(color: Colors.black),),
// ),
// Tab(
// child: Text('4',style:TextStyle(color: Colors.black),),
// ),
// Tab(
// child: Text('5',style:TextStyle(color: Colors.black),),
// )
// ],
// ),
// ),
// ),
// // SliverList(
// //   delegate: SliverChildListDelegate(
// //     [
// //       Expanded(
// //         child: TabBarView(
// //           physics: ScrollPhysics(),
// //           controller: _tabController,
// //           children: [...buildCategoryList()],
// //         ),
// //       ),
// //     ],
// //   ),
// // ),
// ],
// ),
