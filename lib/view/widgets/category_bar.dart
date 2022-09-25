import 'package:flutter/material.dart';
import 'package:restaurant/data/model/dummy_meals.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../data/model/category.dart';
import '../../data/model/dummy_meals.dart';

class CategoryTabBar extends StatefulWidget {
  const CategoryTabBar({Key? key}) : super(key: key);

  @override
  State<CategoryTabBar> createState() => _CategoryTabBarState();
}

class _CategoryTabBarState extends State<CategoryTabBar>
    with SingleTickerProviderStateMixin {
  var selectedCategory = 0;

  var selectedTab = 0;
  var isPressed = false;
  var searchedText;
  late TabController _tabController;
  final ItemScrollController itemScrollController = ItemScrollController();
  final itemPositionsListener = ItemPositionsListener.create();

  Meals myMeals = Meals();
  var selectedChipIndex = 0;
  var isPressed2 = false;
  var isSelected = false;
  var searchedText2;
  int isInit = 0;
  double selectedIndex = 0.0;
  Categories myCategories = Categories();
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

  Widget buildTabView(categoryTitle, List categoryMeals) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => Container(
                  height: 150,
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
                                  Text(myMeals.allMeals[index].mealTitle),
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
                                        myMeals.allMeals[index].mealSizes.first
                                            .sizePrice
                                            .toString(),
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
                ),
            childCount: categoryMeals.length));
  }

  List<Widget> buildAllView() {
    List<Widget> list = [];
    list = myCategories.categories
        .map((e) => buildTabView(e.categoryTitle, e.categoryMeals))
        .toList();
    return list;
  }

  var selectedPage = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: myCategories.categories.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.all(5),
                        child: ChoiceChip(
                          labelPadding: EdgeInsets.all(5),
                          avatar: Icon(
                            Icons.fastfood_outlined,
                            color: index == selectedChipIndex
                                ? Colors.red
                                : Colors.black,
                          ),
                          selectedColor: Colors.orange[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelStyle: index == selectedChipIndex
                              ? TextStyle(color: Colors.deepOrange)
                              : TextStyle(color: Colors.black),
                          backgroundColor: index == selectedChipIndex
                              ? Colors.orangeAccent
                              : Colors.grey[300],
                          onSelected: (selected) {
                            setState(() {
                              isSelected = selected;
                              selectedChipIndex = index;

                              itemScrollController.scrollTo(
                                  index: selectedCategoryItemsIndex(myCategories
                                      .categories[index].categoryTitle),
                                  duration: Duration(seconds: 2),
                                  curve: Curves.easeInOutCubic);
                              // _categoryPageController.animateToPage(index,
                              //     duration: Duration(microseconds: 500),
                              //     curve: Curves.easeIn);
                            });
                          },
                          selected: index == selectedChipIndex ? true : false,
                          label: Text(
                              myCategories.categories[index].categoryTitle),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TabBarView(
                children: buildAllView(),
                controller: _tabController,
              )
            ],
          ),
        ),
      ),
    );
  }
}
