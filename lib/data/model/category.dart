import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dummy_meals.dart';
import 'meal.dart';

class Category {
  late String categoryId;
  late String categoryTitle;
  late String categoryImage;
  late List<Meal> categoryMeals;
  late IconData categoryIcon;
  Category(
      {required this.categoryId,
      required this.categoryImage,
      required this.categoryTitle,
      required this.categoryMeals,
      required this.categoryIcon});

  Category.fromJson(Map<dynamic, dynamic> json) {
    categoryId = json['categoryId'];
    categoryTitle = json['categoryTitle'];
    categoryImage = json['categoryImage'];
    categoryMeals = json['categoryMeals'];
    categoryIcon = json['categoryIcon'];
  }
}

class Categories {
  Categories();
  final List<Category> _categories = [
    Category(
      categoryId: 'c1',
      categoryImage:
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmVlZiUyMGJ1cmdlcnxlbnwwfHwwfHw%3D&w=1000&q=80',
      categoryTitle: 'Pizza',
      categoryMeals: Meals().pizzaMeals,
      categoryIcon: FontAwesomeIcons.pizzaSlice,
    ),
    Category(
        categoryId: 'c2',
        categoryImage:
            'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmVlZiUyMGJ1cmdlcnxlbnwwfHwwfHw%3D&w=1000&q=80',
        categoryTitle: 'Burger',
        categoryMeals: Meals().burgerMeals,
        categoryIcon: FontAwesomeIcons.burger),
    Category(
        categoryId: 'c3',
        categoryImage:
            'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmVlZiUyMGJ1cmdlcnxlbnwwfHwwfHw%3D&w=1000&q=80',
        categoryTitle: 'Pasta',
        categoryMeals: Meals().pastaMeals,
        categoryIcon: FontAwesomeIcons.bowlFood),
    Category(
        categoryId: 'c4',
        categoryImage:
            'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmVlZiUyMGJ1cmdlcnxlbnwwfHwwfHw%3D&w=1000&q=80',
        categoryTitle: 'Shawarma',
        categoryMeals: Meals().shawarmaMeals,
        categoryIcon: FontAwesomeIcons.breadSlice),
    Category(
        categoryId: 'c5',
        categoryImage:
            'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmVlZiUyMGJ1cmdlcnxlbnwwfHwwfHw%3D&w=1000&q=80',
        categoryTitle: 'Fajita',
        categoryMeals: Meals().fajitaMeals,
        categoryIcon: FontAwesomeIcons.breadSlice),
  ];
  List<Category> get categories {
    return [..._categories];
  }

  List<String> get categoriesTitle {
    List<String> titles = categories.map((e) => e.categoryTitle).toList();
    return titles;
  }
}
