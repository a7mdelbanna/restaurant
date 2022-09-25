import 'package:flutter/material.dart';
import 'package:restaurant/data/model/dummy_meals.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../data/model/category.dart';
import '../../helper.dart';
import '../screens/select_restaurant_city.dart';
import '../widgets/offers_list.dart';
import 'colors.dart';
import 'story_button.dart';
import 'toggle_switch.dart';
import 'widgets.dart';

class AppBarActions extends StatefulWidget {
  const AppBarActions({Key? key}) : super(key: key);

  @override
  State<AppBarActions> createState() => _AppBarActionsState();
}

class _AppBarActionsState extends State<AppBarActions> {
  var searchedText;
  bool isPressed = false;
  Widget showSearchField() {
    return Expanded(
      child: ListTile(
        trailing: IconButton(
          onPressed: () {
            setState(() {
              searchedText == null
                  ? isPressed = !isPressed
                  : searchedText = null;
            });
          },
          icon: const Icon(Icons.close, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.search_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            print(searchedText);
            setState(() {
              isPressed = !isPressed;
            });
          },
        ),
        title: SizedBox(
          height: 30,
          child: TextField(
            onChanged: (val) {
              setState(() {
                searchedText = val;
              });
            },
            decoration: const InputDecoration(
              hintText: '...',
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 10,
              ),
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isPressed
        ? showSearchField()
        : IconButton(
            icon: const Icon(
              Icons.search_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                isPressed = !isPressed;
              });
              // showSearch(
              //     delegate: MySearchDelegate(), context: context);
            },
          );
  }
}

class FAppBar extends SliverAppBar {
  final BuildContext context;
  final bool isCollapsed;
  @override
  final double expandedHeight;
  @override
  final double collapsedHeight;
  final AutoScrollController scrollController;
  final TabController tabController;
  final void Function(bool isCollapsed) onCollapsed;
  final void Function(int index) onTap;
  final String cityName;
  FAppBar({
    required this.context,
    required this.isCollapsed,
    required this.expandedHeight,
    required this.collapsedHeight,
    required this.scrollController,
    required this.onCollapsed,
    required this.onTap,
    required this.cityName,
    required this.tabController,
  }) : super(elevation: 2.0, pinned: true, forceElevated: true);
  Categories myCategories = Categories();
  Meals myMeals = Meals();
  @override
  Color? get backgroundColor => Colors.white;
  @override
  List<Widget>? get actions {
    return [AppBarActions()];
  }

  @override
  Widget? get title {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectCity(),
          ),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            cityName,
            style: textTheme.subtitle1?.copyWith(color: scheme.onSurface),
            strutStyle: Helper.buildStrutStyle(textTheme.subtitle1),
          ),
          const SizedBox(width: 4.0),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.expand_more,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? get bottom {
    return PreferredSize(
      preferredSize: const Size.fromHeight(48),
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        color: Colors.white,
        child: TabBar(
          indicator: BoxDecoration(borderRadius: BorderRadius.circular(40)),
          splashBorderRadius: BorderRadius.circular(40),
          isScrollable: true,
          controller: tabController,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          indicatorColor: scheme.primary,
          labelColor: scheme.primary,
          unselectedLabelColor: scheme.onSurface,
          indicatorWeight: 3.0,
          tabs: myCategories.categories.map((e) {
            return Container(
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration:
                    tabController.index == myCategories.categories.indexOf(e)
                        ? BoxDecoration(
                            color: Color(0xFFFFDAB8),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Color(0xFFFFDAB8)))
                        : BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.grey.shade200)),
                child: Tab(text: e.categoryTitle));
          }).toList(),
          onTap: onTap,
        ),
      ),
    );
  }

  @override
  Widget? get flexibleSpace {
    return LayoutBuilder(
      builder: (
        BuildContext context,
        BoxConstraints constraints,
      ) {
        final top = constraints.constrainHeight();
        final collapsedHight =
            MediaQuery.of(context).viewPadding.top + kToolbarHeight + 48;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          onCollapsed(collapsedHight != top);
        });

        return FlexibleSpaceBar(
          collapseMode: CollapseMode.none,
          background: Column(
            children: [
              Container(
                height: MediaQuery.of(context).viewPadding.top +
                    kToolbarHeight -
                    15,
                color: Colors.white,
              ),
              Column(children: [
                Toggle(
                  location: 'Cairo',
                ),
                MyStories(),
                DiscountCard(
                  title: 'Buy 2 get 1 for free',
                  subtitle: 'till 30,july',
                  image: 'assets/images/pizza.jpg',
                ),
                myMeals.offers.length > 0
                    ? OffersList(
                        meals: myMeals,
                      )
                    : SizedBox(
                        height: 4,
                      ),
              ]),
            ],
          ),
        );
      },
    );
  }
}
