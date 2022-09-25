import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        title: TextField(
          onChanged: (val) {
            setState(() {
              searchedText = val;
            });
          },
          decoration: InputDecoration(
            hintText: '...',
            hintStyle: TextStyle(
              color: Colors.black,
              fontSize: 10.sp,
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

class CustomAppBar extends SliverAppBar {
  final BuildContext context;

  @override
  final double expandedHeight;
  @override
  final double collapsedHeight;
  double? appBarElevation;
  Widget? appBarBottom;
  Widget? appBarFlex;
  double? bottomHeight;
  List<Widget>? customActions;
  Widget customTitle;
  Color appBarBackgroundColor;
  CustomAppBar({
    required this.customTitle,
    this.customActions = const [const SizedBox(height: 0)],
    required this.context,
    this.appBarElevation = 2,
    required this.expandedHeight,
    required this.collapsedHeight,
    this.appBarBackgroundColor = Colors.white,
    this.appBarBottom = const SizedBox(
      height: 0,
    ),
    this.bottomHeight = 0,
    this.appBarFlex = const SizedBox(height: 0),
  }) : super(
            titleTextStyle: Theme.of(context).textTheme.headline2,
            floating: true,
            automaticallyImplyLeading: true,
            elevation: appBarElevation,
            pinned: true,
            centerTitle: true,
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor));

  @override
  Color? get backgroundColor => appBarBackgroundColor;
  @override
  List<Widget>? get actions => customActions;
  @override
  Widget? get title => customTitle;

  @override
  PreferredSizeWidget? get bottom {
    return PreferredSize(
      preferredSize: Size.fromHeight(bottomHeight!),
      child: appBarBottom!,
    );
  }

  @override
  Widget? get flexibleSpace {
    return FlexibleSpaceBar(
      collapseMode: CollapseMode.none,
      background: appBarFlex,
    );
  }
}
