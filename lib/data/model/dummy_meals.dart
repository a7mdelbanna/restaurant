import 'package:restaurant/data/model/topping.dart';

import 'category.dart';
import 'meal.dart';

class Meals {
  Meals();

  final List<Meal> _pizzaMeals = [
    Meal(
      mealDescription: 'Superspreme Pizza made with love and passion',
      mealId: 'm1',
      mealTitle: 'superspreme',
      mealIngredients: ['dough', 'tomato', 'cheese'],
      isVegan: false,
      mealImageUrl: 'assets/images/pizza.jpg',
      categoryId: '',
      mealSizes: [
        MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
        MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
        MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
      ],
      mealCode: '',
      categoryName: '',
    ),
    Meal(
        mealDescription: 'Superspreme Pizza made with love and passion',
        mealId: 'm2',
        mealTitle: 'superspreme',
        mealIngredients: ['dough', 'tomato', 'cheese'],
        isVegan: false,
        mealImageUrl: 'assets/images/pizza1.png',
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: ''),
    Meal(
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        mealDescription: 'Superspreme Pizza made with love and passion',
        mealId: 'm3',
        mealTitle: 'superspreme',
        mealIngredients: ['dough', 'tomato', 'cheese'],
        isVegan: false,
        mealImageUrl: 'assets/images/pizza2.jpg'),
    Meal(
        mealDescription: 'Superspreme Pizza made with love and passion',
        mealId: 'm4',
        mealTitle: 'superspreme',
        mealIngredients: ['dough', 'tomato', 'cheese'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/pizza3.png'),
    Meal(
        mealDescription: 'Superspreme Pizza made with love and passion',
        mealId: 'm5',
        mealTitle: 'superspreme',
        mealIngredients: ['dough', 'tomato', 'cheese'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/pizza4.jpg'),
  ];
  final List<Meal> _burgerMeals = [
    Meal(
        mealDescription: 'Cheese burger made with love and passion',
        mealId: 'm6',
        mealTitle: 'cheese burger',
        mealIngredients: ['cheese', 'meat', 'tomato'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/burger.jpg'),
    Meal(
        mealDescription: 'Cheese burger made with love and passion',
        mealId: 'm7',
        mealTitle: 'cheese burger',
        mealIngredients: ['cheese', 'meat', 'tomato'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/burger2.jpg'),
    Meal(
        mealDescription: 'Cheese burger made with love and passion',
        mealId: 'm8',
        mealTitle: 'cheese burger',
        mealIngredients: ['cheese', 'meat', 'tomato'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/burger3.jpg'),
    Meal(
        mealDescription: 'Cheese burger made with love and passion',
        mealId: 'm9',
        mealTitle: 'cheese burger',
        mealIngredients: ['cheese', 'meat', 'tomato'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/burger4.jpg'),
    Meal(
        mealDescription: 'Cheese burger made with love and passion',
        mealId: 'm10',
        mealTitle: 'cheese burger',
        mealIngredients: ['cheese', 'meat', 'tomato'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/burger5.jpg'),
  ];
  final List<Meal> _pastaMeals = [
    Meal(
        mealDescription: 'Mac&cheese made with love and passion',
        mealId: 'm11',
        mealTitle: 'Mac&Cheese',
        mealIngredients: ['pasta', 'oil', 'cheese'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/pasta.jpg'),
    Meal(
        mealDescription: 'Mac&cheese made with love and passion',
        mealId: 'm12',
        mealTitle: 'Mac&Cheese',
        mealIngredients: ['pasta', 'oil', 'cheese'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/pasta2.jpg'),
    Meal(
        mealDescription: 'Mac&cheese made with love and passion',
        mealId: 'm13',
        mealTitle: 'Mac&Cheese',
        mealIngredients: ['pasta', 'oil', 'cheese'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/pasta3.jpg'),
    Meal(
        mealDescription: 'Mac&cheese made with love and passion',
        mealId: 'm14',
        mealTitle: 'Mac&Cheese',
        mealIngredients: ['pasta', 'oil', 'cheese'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/pasta4.jpg'),
  ];
  final List<Meal> _shawarmaMeals = [
    Meal(
        mealDescription: 'Shawarma Pizza made with love and passion',
        mealId: 'm16',
        mealTitle: 'shawarma',
        mealIngredients: ['bread', 'fajita', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/shawarma.jpg'),
    Meal(
        mealDescription: 'Shawarma Pizza made with love and passion',
        mealId: 'm16',
        mealTitle: 'shawarma',
        mealIngredients: ['bread', 'fajita', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/shawarma.jpg'),
    Meal(
        mealDescription: 'Shawarma Pizza made with love and passion',
        mealId: 'm16',
        mealTitle: 'shawarma',
        mealIngredients: ['bread', 'fajita', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/shawarma.jpg'),
    Meal(
        mealDescription: 'Shawarma Pizza made with love and passion',
        mealId: 'm16',
        mealTitle: 'shawarma',
        mealIngredients: ['bread', 'fajita', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/shawarma.jpg'),
    Meal(
        mealDescription: 'Shawarma Pizza made with love and passion',
        mealId: 'm16',
        mealTitle: 'shawarma',
        mealIngredients: ['bread', 'fajita', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/shawarma.jpg'),
  ];
  final List<Meal> _fajitaMeals = [
    Meal(
        mealDescription: 'Fajita Pizza made with love and passion',
        mealId: 'm21',
        mealTitle: 'fajita',
        mealIngredients: ['fajita', 'tomato', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/fajita.jpg'),
    Meal(
        mealDescription: 'Fajita Pizza made with love and passion',
        mealId: 'm21',
        mealTitle: 'fajita',
        mealIngredients: ['fajita', 'tomato', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/fajita.jpg'),
    Meal(
        mealDescription: 'Fajita Pizza made with love and passion',
        mealId: 'm21',
        mealTitle: 'fajita',
        mealIngredients: ['fajita', 'tomato', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/fajita.jpg'),
    Meal(
        mealDescription: 'Fajita Pizza made with love and passion',
        mealId: 'm21',
        mealTitle: 'fajita',
        mealIngredients: ['fajita', 'tomato', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/fajita.jpg'),
    Meal(
        mealDescription: 'Fajita Pizza made with love and passion',
        mealId: 'm21',
        mealTitle: 'fajita',
        mealIngredients: ['fajita', 'tomato', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/fajita.jpg'),
  ];
  final List<Meal> _offers = [
    Meal(
        mealDescription: 'Fajita Pizza made with love and passion',
        mealId: 'm21',
        mealTitle: 'fajita',
        mealIngredients: ['fajita', 'tomato', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/fajita.jpg'),
    Meal(
        mealDescription: 'Fajita Pizza made with love and passion',
        mealId: 'm21',
        mealTitle: 'fajita',
        mealIngredients: ['fajita', 'tomato', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/fajita.jpg'),
    Meal(
        mealDescription: 'Fajita Pizza made with love and passion',
        mealId: 'm21',
        mealTitle: 'fajita',
        mealIngredients: ['fajita', 'tomato', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/fajita.jpg'),
    Meal(
        mealDescription: 'Fajita Pizza made with love and passion',
        mealId: 'm21',
        mealTitle: 'fajita',
        mealIngredients: ['fajita', 'tomato', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/fajita.jpg'),
    Meal(
        mealDescription: 'Fajita Pizza made with love and passion',
        mealId: 'm21',
        mealTitle: 'fajita',
        mealIngredients: ['fajita', 'tomato', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/fajita.jpg'),
    Meal(
        mealDescription: 'Fajita Pizza made with love and passion',
        mealId: 'm21',
        mealTitle: 'fajita',
        mealIngredients: ['fajita', 'tomato', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/fajita.jpg'),
  ];
  final List<Meal> _allMeals = [
    Meal(
        mealDescription: 'Fajita Pizza made with love and passion',
        mealId: 'm21',
        mealTitle: 'fajita',
        mealIngredients: ['fajita', 'tomato', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/fajita.jpg'),
    Meal(
        mealDescription: 'Fajita Pizza made with love and passion',
        mealId: 'm21',
        mealTitle: 'fajita',
        mealIngredients: ['fajita', 'tomato', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/fajita.jpg'),
    Meal(
        mealDescription: 'Fajita Pizza made with love and passion',
        mealId: 'm21',
        mealTitle: 'fajita',
        mealIngredients: ['fajita', 'tomato', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/fajita.jpg'),
    Meal(
        mealDescription: 'Fajita Pizza made with love and passion',
        mealId: 'm21',
        mealTitle: 'fajita',
        mealIngredients: ['fajita', 'tomato', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/fajita.jpg'),
    Meal(
        mealDescription: 'Fajita Pizza made with love and passion',
        mealId: 'm21',
        mealTitle: 'fajita',
        mealIngredients: ['fajita', 'tomato', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/fajita.jpg'),
    Meal(
        mealDescription: 'Shawarma Pizza made with love and passion',
        mealId: 'm16',
        mealTitle: 'shawarma',
        mealIngredients: ['bread', 'fajita', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/shawarma.jpg'),
    Meal(
        mealDescription: 'Shawarma Pizza made with love and passion',
        mealId: 'm16',
        mealTitle: 'shawarma',
        mealIngredients: ['bread', 'fajita', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/shawarma.jpg'),
    Meal(
        mealDescription: 'Shawarma Pizza made with love and passion',
        mealId: 'm16',
        mealTitle: 'shawarma',
        mealIngredients: ['bread', 'fajita', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/shawarma.jpg'),
    Meal(
        mealDescription: 'Shawarma Pizza made with love and passion',
        mealId: 'm16',
        mealTitle: 'shawarma',
        mealIngredients: ['bread', 'fajita', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/shawarma.jpg'),
    Meal(
        mealDescription: 'Shawarma Pizza made with love and passion',
        mealId: 'm16',
        mealTitle: 'shawarma',
        mealIngredients: ['bread', 'fajita', 'onion'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/shawarma.jpg'),
    Meal(
        mealDescription: 'Mac&cheese made with love and passion',
        mealId: 'm11',
        mealTitle: 'Mac&Cheese',
        mealIngredients: ['pasta', 'oil', 'cheese'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/pasta.jpg'),
    Meal(
        mealDescription: 'Mac&cheese made with love and passion',
        mealId: 'm12',
        mealTitle: 'Mac&Cheese',
        mealIngredients: ['pasta', 'oil', 'cheese'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/pasta2.jpg'),
    Meal(
        mealDescription: 'Mac&cheese made with love and passion',
        mealId: 'm13',
        mealTitle: 'Mac&Cheese',
        mealIngredients: ['pasta', 'oil', 'cheese'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/pasta3.jpg'),
    Meal(
        mealDescription: 'Mac&cheese made with love and passion',
        mealId: 'm14',
        mealTitle: 'Mac&Cheese',
        mealIngredients: ['pasta', 'oil', 'cheese'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/pasta4.jpg'),
    Meal(
        mealDescription: 'Cheese burger made with love and passion',
        mealId: 'm6',
        mealTitle: 'cheese burger',
        mealIngredients: ['cheese', 'meat', 'tomato'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/burger.jpg'),
    Meal(
        mealDescription: 'Cheese burger made with love and passion',
        mealId: 'm7',
        mealTitle: 'cheese burger',
        mealIngredients: ['cheese', 'meat', 'tomato'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/burger2.jpg'),
    Meal(
        mealDescription: 'Cheese burger made with love and passion',
        mealId: 'm8',
        mealTitle: 'cheese burger',
        mealIngredients: ['cheese', 'meat', 'tomato'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/burger3.jpg'),
    Meal(
        mealDescription: 'Cheese burger made with love and passion',
        mealId: 'm9',
        mealTitle: 'cheese burger',
        mealIngredients: ['cheese', 'meat', 'tomato'],
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        isVegan: false,
        mealImageUrl: 'assets/images/burger4.jpg'),
    Meal(
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        mealDescription: 'Cheese burger made with love and passion',
        mealId: 'm10',
        mealTitle: 'cheese burger',
        mealIngredients: ['cheese', 'meat', 'tomato'],
        isVegan: false,
        mealImageUrl: 'assets/images/burger5.jpg'),
    Meal(
      categoryId: '',
      mealSizes: [
        MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
        MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
        MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
      ],
      mealCode: '',
      categoryName: '',
      mealDescription: 'Superspreme Pizza made with love and passion',
      mealId: 'm1',
      mealTitle: 'superspreme',
      mealIngredients: ['dough', 'tomato', 'cheese'],
      isVegan: false,
      mealImageUrl: 'assets/images/pizza.jpg',
    ),
    Meal(
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        mealDescription: 'Superspreme Pizza made with love and passion',
        mealId: 'm2',
        mealTitle: 'superspreme',
        mealIngredients: ['dough', 'tomato', 'cheese'],
        isVegan: false,
        mealImageUrl: 'assets/images/pizza1.png'),
    Meal(
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        mealDescription: 'Superspreme Pizza made with love and passion',
        mealId: 'm3',
        mealTitle: 'superspreme',
        mealIngredients: ['dough', 'tomato', 'cheese'],
        isVegan: false,
        mealImageUrl: 'assets/images/pizza2.jpg'),
    Meal(
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        mealDescription: 'Superspreme Pizza made with love and passion',
        mealId: 'm4',
        mealTitle: 'superspreme',
        mealIngredients: ['dough', 'tomato', 'cheese'],
        isVegan: false,
        mealImageUrl: 'assets/images/pizza3.png'),
    Meal(
        categoryId: '',
        mealSizes: [
          MealSize(sizeId: '1', sizeName: 'small', sizePrice: 50),
          MealSize(sizeId: '2', sizeName: 'medium', sizePrice: 60),
          MealSize(sizeId: '3', sizeName: 'large', sizePrice: 70),
        ],
        mealCode: '',
        categoryName: '',
        mealDescription: 'Superspreme Pizza made with love and passion',
        mealId: 'm5',
        mealTitle: 'superspreme',
        mealIngredients: ['dough', 'tomato', 'cheese'],
        isVegan: false,
        mealImageUrl: 'assets/images/pizza4.jpg'),
  ];
  List<Meal> get pizzaMeals {
    return [..._pizzaMeals];
  }

  List<Meal> get pastaMeals {
    return [..._pastaMeals];
  }

  List<Meal> get burgerMeals {
    return [..._burgerMeals];
  }

  List<Meal> get allMeals {
    return [..._allMeals];
  }

  List<Meal> get offers {
    return [..._offers];
  }

  List<Meal> get fajitaMeals {
    return [..._fajitaMeals];
  }

  List<Meal> get shawarmaMeals {
    return [..._shawarmaMeals];
  }

  int categoryFirstIndex(String categoryTitle) {
    int index = 0;
    Meal meal =
        allMeals.firstWhere((element) => element.categoryName == categoryTitle);
    return _allMeals.indexOf(meal);
  }

  int categoryIndex(int index) {
    String categoryTitle = '';
    Categories myCategories = Categories();
    int categoryIndex = 0;
    categoryTitle = allMeals[index].categoryName;

    Category category = myCategories.categories
        .firstWhere((element) => element.categoryTitle == categoryTitle);

    categoryIndex = myCategories.categories.indexOf(category);

    return categoryIndex;
  }
}

class Toppings {
  List<CustomTopping> toppings = [
    CustomTopping(
        toppingTitle: 'onion',
        toppingImageUrl: 'assets/images/pizza.jpg',
        toppingId: '1',
        toppingSizes: [
          ToppingSize(sizeId: '1', sizeName: 'small', sizePrice: 1),
          ToppingSize(sizeId: '2', sizeName: 'medium', sizePrice: 12),
          ToppingSize(sizeId: '3', sizeName: 'large', sizePrice: 23),
        ]),
    CustomTopping(
        toppingTitle: 'cheese',
        toppingImageUrl: 'assets/images/pizza.jpg',
        toppingId: '2',
        toppingSizes: [
          ToppingSize(sizeId: '1', sizeName: 'small', sizePrice: 2),
          ToppingSize(sizeId: '2', sizeName: 'medium', sizePrice: 13),
          ToppingSize(sizeId: '3', sizeName: 'large', sizePrice: 24),
        ]),
    CustomTopping(
        toppingTitle: 'pepper',
        toppingImageUrl: 'assets/images/pizza.jpg',
        toppingId: '3',
        toppingSizes: [
          ToppingSize(sizeId: '1', sizeName: 'small', sizePrice: 3),
          ToppingSize(sizeId: '2', sizeName: 'medium', sizePrice: 14),
          ToppingSize(sizeId: '3', sizeName: 'large', sizePrice: 25),
        ]),
    CustomTopping(
        toppingTitle: 'mushroom',
        toppingImageUrl: 'assets/images/pizza.jpg',
        toppingId: '4',
        toppingSizes: [
          ToppingSize(sizeId: '1', sizeName: 'small', sizePrice: 4),
          ToppingSize(sizeId: '2', sizeName: 'medium', sizePrice: 15),
          ToppingSize(sizeId: '3', sizeName: 'large', sizePrice: 26),
        ]),
    CustomTopping(
        toppingTitle: 'meat',
        toppingImageUrl: 'assets/images/pizza.jpg',
        toppingId: '5',
        toppingSizes: [
          ToppingSize(sizeId: '1', sizeName: 'small', sizePrice: 5),
          ToppingSize(sizeId: '2', sizeName: 'medium', sizePrice: 16),
          ToppingSize(sizeId: '3', sizeName: 'large', sizePrice: 27),
        ]),
    CustomTopping(
        toppingTitle: 'garlic',
        toppingImageUrl: 'assets/images/pizza.jpg',
        toppingId: '6',
        toppingSizes: [
          ToppingSize(sizeId: '1', sizeName: 'small', sizePrice: 6),
          ToppingSize(sizeId: '2', sizeName: 'medium', sizePrice: 17),
          ToppingSize(sizeId: '3', sizeName: 'large', sizePrice: 28),
        ]),
    CustomTopping(
        toppingTitle: 'tomato',
        toppingImageUrl: 'assets/images/pizza.jpg',
        toppingId: '7',
        toppingSizes: [
          ToppingSize(sizeId: '1', sizeName: 'small', sizePrice: 7),
          ToppingSize(sizeId: '2', sizeName: 'medium', sizePrice: 18),
          ToppingSize(sizeId: '3', sizeName: 'large', sizePrice: 29),
        ]),
    CustomTopping(
        toppingTitle: 'sauce',
        toppingImageUrl: 'assets/images/pizza.jpg',
        toppingId: '8',
        toppingSizes: [
          ToppingSize(sizeId: '1', sizeName: 'small', sizePrice: 8),
          ToppingSize(sizeId: '2', sizeName: 'medium', sizePrice: 19),
          ToppingSize(sizeId: '3', sizeName: 'large', sizePrice: 30),
        ]),
    CustomTopping(
        toppingTitle: 'olives',
        toppingImageUrl: 'assets/images/pizza.jpg',
        toppingId: '9',
        toppingSizes: [
          ToppingSize(sizeId: '1', sizeName: 'small', sizePrice: 9),
          ToppingSize(sizeId: '2', sizeName: 'medium', sizePrice: 20),
          ToppingSize(sizeId: '3', sizeName: 'large', sizePrice: 31),
        ]),
    CustomTopping(
        toppingTitle: 'fajita',
        toppingImageUrl: 'assets/images/pizza.jpg',
        toppingId: '10',
        toppingSizes: [
          ToppingSize(sizeId: '1', sizeName: 'small', sizePrice: 10),
          ToppingSize(sizeId: '2', sizeName: 'medium', sizePrice: 21),
          ToppingSize(sizeId: '3', sizeName: 'large', sizePrice: 32),
        ]),
    CustomTopping(
        toppingTitle: 'shawarma',
        toppingImageUrl: 'assets/images/pizza.jpg',
        toppingId: '11',
        toppingSizes: [
          ToppingSize(sizeId: '1', sizeName: 'small', sizePrice: 11),
          ToppingSize(sizeId: '2', sizeName: 'medium', sizePrice: 22),
          ToppingSize(sizeId: '3', sizeName: 'large', sizePrice: 33),
        ]),
  ];
}
