import 'package:flutter/material.dart';

import '../../data/model/category.dart';
import '../../data/model/meal.dart';
import '../screens/food_details_screen.dart';
import 'colors.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: const EdgeInsets.only(bottom: 16),
      color: scheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTileHeader(context),
          _buildFoodTileList(context),
        ],
      ),
    );
  }

  Widget _buildFoodTileList(BuildContext context) {
    return Column(
        children: category.categoryMeals.map((e) {
      final Meal meal = e;
      bool isLastIndex = category.categoryMeals.indexOf(e) ==
          category.categoryMeals.length - 1;
      return Column(
        children: [
          _buildFoodTile(
            meal: meal,
            context: context,
          ),
          !isLastIndex
              ? Divider(
                  height: 5,
                )
              : SizedBox(
                  height: 5,
                )
        ],
      );
    }).toList());
  }

  Widget _buildSectionTileHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              category.categoryTitle,
              style:
                  _textTheme(context).headline6!.copyWith(color: Colors.black),
            )
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildFoodTile({
    required BuildContext context,
    required Meal meal,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodDetailsScreen(meal: meal),
          ),
        );
      },
      child: Column(
        children: [
          SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFoodImage(meal.mealImageUrl),
              SizedBox(
                width: 25,
              ),
              Expanded(child: _buildFoodDetail(meal: meal, context: context)),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          // !isLastIndex ? const Divider(height: 16.0) : const SizedBox(height: 8.0)
        ],
      ),
    );
  }

  Widget _buildFoodImage(String url) {
    return Hero(
      tag: 'ItemImage',
      child: CircleAvatar(
        radius: 45,
        backgroundImage: AssetImage(url),
      ),
    );
  }

  Widget _buildFoodDetail({
    required BuildContext context,
    required Meal meal,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(meal.mealTitle.toUpperCase(),
            style:
                _textTheme(context).subtitle1!.copyWith(color: Colors.black)),
        const SizedBox(height: 4),
        Container(
          width: 200,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  meal.mealDescription,
                  softWrap: true,
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent[100],
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Text(
                  meal.mealSizes.first.sizePrice.toStringAsFixed(2) + 'LE',
                  style: TextStyle(color: Colors.deepOrange),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Widget _buildSectionHoteSaleIcon() {
  //   return Container(
  //     margin: const EdgeInsets.only(right: 4.0),
  //     child: Icon(
  //       Icons.whatshot,
  //       color: scheme.primary,
  //       size: 20.0,
  //     ),
  //   );
  // }
  //
  // Widget _buildFoodHotSaleIcon() {
  //   return Container(
  //     child: Icon(Icons.whatshot, color: scheme.primary, size: 16.0),
  //     padding: const EdgeInsets.all(4.0),
  //     decoration: BoxDecoration(
  //       color: scheme.primary.withOpacity(0.1),
  //       borderRadius: BorderRadius.circular(16.0),
  //     ),
  //   );
  // }

  TextTheme _textTheme(context) => Theme.of(context).textTheme;
}
