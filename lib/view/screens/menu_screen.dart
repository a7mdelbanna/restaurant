import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:restaurant/data/model/category.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../widgets/category_section.dart';
import '../widgets/colors.dart';
import '../widgets/example_data.dart';
import '../widgets/widgets.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = false;
  late AutoScrollController scrollController;
  late TabController tabController;
  Categories myCategories = Categories();
  final double expandedHeight = 530.0.h;
  final PageData data = ExampleData.data;
  final double collapsedHeight = kToolbarHeight.h;

  final listViewKey = RectGetter.createGlobalKey();
  Map<int, dynamic> itemKeys = {};
  List<dynamic> globalkeyList = [];
  // prevent animate when press on tab bar
  bool pauseRectGetterIndex = false;
  createCategoryGlobalkey() {
    myCategories.categories.forEach((element) {
      globalkeyList.add(RectGetter.createGlobalKey());
    });
  }

  @override
  void initState() {
    tabController =
        TabController(length: myCategories.categories.length, vsync: this);
    scrollController = AutoScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    tabController.dispose();
    super.dispose();
  }

  // List<int> getVisibleItemsIndex() {
  //   Rect? rect = RectGetter.getRectFromKey(listViewKey);
  //   print(rect);
  //   List<int> items = [];
  //   if (rect == null) return items;
  //   itemKeys.forEach((index, key) {
  //     Rect? itemRect = RectGetter.getRectFromKey(key);
  //     print(itemRect);
  //     if (itemRect == null) return;
  //     if(itemRect.bottom>rect.top&&itemRect.bottom<rect.bottom)
  //     // if (itemRect.top > rect.bottom) return;
  //     // if (itemRect.bottom < rect.top) return;
  //     if (itemRect.top < 0 && itemRect.bottom < 0) return;
  //
  //     items.add(index);
  //     print(items);
  //   });
  //   return items;
  // }

  int getVisibleItemsIndex() {
    Rect? rect = RectGetter.getRectFromKey(listViewKey);
    print(rect);
    int visibleIndex = 0;
    if (rect == null) return visibleIndex;
    List<Rect?> itemRectList = [];
    itemKeys.forEach((index, key) {
      itemRectList.add(RectGetter.getRectFromKey(key));
    });
    itemKeys.forEach((index, key) {
      Rect? itemRect = RectGetter.getRectFromKey(key);
      print(itemRect);
      if (itemRect == null) return;
      if (itemRect.top < 0 && itemRect.bottom < 0) return;
      if (itemRect.bottom > rect.top && itemRect.bottom < rect.bottom) {
        visibleIndex = index;
      }
      if (itemRectList[index]!.top > rect.top &&
          itemRectList[index]!.top < rect.bottom) {
        if (index > 0) {
          if (itemRectList[index - 1]!.bottom - 134.4 > rect.top &&
              itemRectList[index - 1]!.bottom - 134.4 < rect.bottom) {
            visibleIndex = index - 1;
          } else
            visibleIndex = index;
        }
      }

      // if (itemRect.top > rect.bottom) return;
      // if (itemRect.bottom < rect.top) return;

      print(visibleIndex);
    });
    return visibleIndex;
  }

  void onCollapsed(bool value) {
    if (this.isCollapsed == value) return;
    setState(() => this.isCollapsed = value);
  }

  // bool onScrollNotification(ScrollNotification notification) {
  //   if (pauseRectGetterIndex) return false;
  //   int lastTabIndex = tabController.length - 1;
  //   List<int> visibleItems = getVisibleItemsIndex();
  //
  //   bool reachLastTabIndex =
  //       visibleItems.length <= 2 && visibleItems.last == lastTabIndex;
  //   if (reachLastTabIndex) {
  //     tabController.animateTo(lastTabIndex);
  //   } else {
  //     // int sumIndex = visibleItems.reduce((value, element) {
  //     //   print(value.toString());
  //     //   print(element.toString());
  //     //   return value + element;
  //     // });
  //     // int middleIndex = sumIndex ~/ visibleItems.length;
  //     // if (tabController.index != middleIndex)
  //     //   tabController.animateTo(middleIndex);
  //     tabController.animateTo(visibleItems.first);
  //   }
  //
  //   return false;
  // }
  bool onScrollNotification(ScrollNotification notification) {
    if (pauseRectGetterIndex) return false;
    int lastTabIndex = tabController.length - 1;
    int visibleItems = getVisibleItemsIndex();

    bool reachLastTabIndex = visibleItems == lastTabIndex;
    if (reachLastTabIndex) {
      tabController.animateTo(lastTabIndex);
      setState(() {});
    } else {
      tabController.animateTo(visibleItems);
      setState(() {});
      // int sumIndex = visibleItems.reduce((value, element) {
      //   print(value.toString());
      //   print(element.toString());
      //   return value + element;
      // });
      // int middleIndex = sumIndex ~/ visibleItems.length;
      // if (tabController.index != middleIndex)
      //   tabController.animateTo(middleIndex);
      // //tabController.animateTo(visibleItems.first);
    }

    return false;
  }

  void animateAndScrollTo(int index) {
    pauseRectGetterIndex = true;
    print(index);
    tabController.animateTo(index);
    scrollController
        .scrollToIndex(index, preferPosition: AutoScrollPosition.begin)
        .then((value) => pauseRectGetterIndex = false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: scheme.background,
      body: RectGetter(
        key: listViewKey,
        child: NotificationListener<ScrollNotification>(
          child: buildSliverScrollView(),
          onNotification: onScrollNotification,
        ),
      ),
    );
  }

  Widget buildSliverScrollView() {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      controller: scrollController,
      slivers: [
        buildAppBar(),
        buildBody(),
      ],
    );
  }

  SliverAppBar buildAppBar() {
    return FAppBar(
      cityName: 'Giza',
      context: context,
      scrollController: scrollController,
      expandedHeight: expandedHeight,
      collapsedHeight: collapsedHeight,
      isCollapsed: isCollapsed,
      onCollapsed: onCollapsed,
      tabController: tabController,
      onTap: (index) {
        animateAndScrollTo(index);
        setState(() {});
      },
    );
  }

  SliverList buildBody() {
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(myCategories.categories.length, (index) {
          itemKeys[index] = RectGetter.createGlobalKey();
          print(itemKeys[index]);
          return buildCategoryItem(index);
        }),
      ),
    );
  }

  Widget buildCategoryItem(int index) {
    return RectGetter(
      key: itemKeys[index],
      child: AutoScrollTag(
        key: GlobalKey(),
        index: index,
        controller: scrollController,
        child: Column(
          children: [CategorySection(category: myCategories.categories[index])],
        ),
      ),
    );
  }
}
