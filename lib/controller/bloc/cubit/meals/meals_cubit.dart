import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant/data/model/topping.dart';

import '../../../../data/exceptions.dart';
import '../../../../data/model/category.dart';
import '../../../../data/model/dummy_meals.dart';
import '../../../../data/model/meal.dart';
import '../../../../data/repositories/categories_repository.dart';
import '../../../../data/repositories/meal_repository.dart';

part 'meals_state.dart';

class MealsCubit extends Cubit<MealState> {
  final MealsRepository itemsRepository;
  CategoriesRepository categoriesRepository;
  late List<Meal> meals = [];
  // SettingsRepository settingsRepository;
  List<Category> categories = [];
  List<Meal> preSearchItems = [];
  List<CustomTopping> customToppings = [];
  List<Meal> favItems = [];
  List<Meal> tempItems = [];
  List<Meal> offerItems = [];

  bool shouldUpdate = false;
  // List<SettingsConfig> configs= [];
  MealsCubit(this.itemsRepository, this.categoriesRepository)
      : super(MealsInitial());

  List<Meal> getMeals() {
    meals = Meals().allMeals;
    return meals;
  }

  List<CustomTopping> getToppings() {
    customToppings = Toppings().toppings;
    return customToppings;
  }

  getAllItemsAndCategories() async {
    try {
      emit(MealsLoadingState());

      meals = (await itemsRepository.getAllItems()) as List<Meal>;
      categories = await categoriesRepository.getAllCategories();

      print(meals.length);
      print(categories.length);

      emit(MealsReadyState());
    } on TimeOutException catch (e) {
      emit(MealsTimeoutErrorState(e.toString()));
    } on DataException catch (e) {
      emit(MealsDataErrorState(e.toString()));
    }
  }

  getSelectedSizeBysizeId() {}
  getAllItems() async {
    try {
      emit(MealsLoadingState());

      meals = (await itemsRepository.getAllItems()) as List<Meal>;
      emit(MealsReadyState());
    } on TimeOutException catch (e) {
      emit(MealsTimeoutErrorState(e.toString()));
    } on DataException catch (e) {
      emit(MealsDataErrorState(e.toString()));
    }
  }

  List<Category> getCategories() {
    return categories;
  }

  List<Meal> getItemsByCompany(companyName) {
    List<Meal> companyItems =
        meals.where((element) => element.categoryName == companyName).toList();
    return companyItems;
  }

  // Future checkItemsQuantitiesAndPrices(
  //     {required List<Meal> cartItems, required bool useItemBalance}) async {
  //   List<CartItem> tempCart = [...cartItems];
  //   bool cartChanged = false;
  //
  //   tempMeals = (await itemsRepository.getAllItems()) as List<Meal>;
  //   print(tempItems.length);
  //   for (Meal meal in tempItems) {
  //     for (CartItem cartItem in tempCart) {
  //       if (cartItem.id == meal.mealId) {
  //         bool changed = false;
  //         if (useItemBalance) {
  //
  //
  //           if (cartItem.quantity > int.parse(meal.itemBalance!)) {
  //             tempCart.remove(cartItem);
  //             changed = true;
  //             cartChanged = true;
  //           }
  //           if (changed == false) {
  //             String unit = cartItem.unitId;
  //             double newPrice = item.itemUnits!
  //                     .firstWhere((element) => element.unitId == unit)
  //                     .unitPrice +
  //                 0.0;
  //             double oldPrice = cartItem.price!;
  //             if (newPrice != oldPrice) {
  //               print('insidepricecheck');
  //               print(tempCart.elementAt(tempCart.indexOf(cartItem)).price);
  //               print(newPrice);
  //               tempCart.elementAt(tempCart.indexOf(cartItem)).price = newPrice;
  //               tempCart.elementAt(tempCart.indexOf(cartItem)).itemTotal =
  //                   newPrice *
  //                       tempCart.elementAt(tempCart.indexOf(cartItem)).quantity;
  //               tempCart.elementAt(tempCart.indexOf(cartItem)).net = newPrice -
  //                   tempCart.elementAt(tempCart.indexOf(cartItem)).offerDis!;
  //               print(tempCart.elementAt(tempCart.indexOf(cartItem)).price);
  //               cartChanged = true;
  //             }
  //           }
  //         } else {
  //           String unit = cartItem.unitId;
  //           double newPrice = item.itemUnits!
  //                   .firstWhere((element) => element.unitId == unit)
  //                   .unitPrice +
  //               0.0;
  //           double oldPrice = cartItem.price!;
  //           if (newPrice != oldPrice) {
  //             print('insidepricecheck');
  //             print(tempCart.elementAt(tempCart.indexOf(cartItem)).price);
  //             print(newPrice);
  //             tempCart.elementAt(tempCart.indexOf(cartItem)).price = newPrice;
  //             tempCart.elementAt(tempCart.indexOf(cartItem)).itemTotal =
  //                 newPrice *
  //                     tempCart.elementAt(tempCart.indexOf(cartItem)).quantity;
  //             tempCart.elementAt(tempCart.indexOf(cartItem)).net = newPrice -
  //                 tempCart.elementAt(tempCart.indexOf(cartItem)).offerDis!;
  //             print(tempCart.elementAt(tempCart.indexOf(cartItem)).price);
  //             cartChanged = true;
  //           }
  //         }
  //       }
  //     }
  //   }
  //   if (cartChanged) {
  //     Fluttertoast.showToast(
  //       msg: TextVar.item_quantity_price_changed,
  //       toastLength: Toast.LENGTH_SHORT, // length
  //     );
  //
  //     emit(ItemsLoadingState());
  //     items = tempItems;
  //     emit(ItemsLoadedState(items));
  //     return tempCart;
  //   } else {
  //     return true;
  //   }
  // }

  // bool shouldUpdate(update) {
  //   return update;
  // }
  //
  // uploadItemImage(
  //   itemId,
  //   itemName,
  //   String imageUrl,
  // ) {
  //   emit(Meals());
  //   itemsRepository.uploadItemImage(itemId, itemName, imageUrl).then((value) {
  //     if (value) {
  //       Fluttertoast.showToast(
  //         msg: 'تم حفظ الصورة',
  //         toastLength: Toast.LENGTH_SHORT, // length
  //       );
  //     } else {
  //       Fluttertoast.showToast(
  //         msg: 'لم يتم الحفظ، حاول لاحقاً',
  //         toastLength: Toast.LENGTH_SHORT, // length
  //       );
  //     }
  //   }).catchError((e) {
  //     Fluttertoast.showToast(
  //       msg: 'لم يتم الحفظ، حاول لاحقاً',
  //       toastLength: Toast.LENGTH_SHORT, // length
  //     );
  //   });
  //   emit(ItemImageUploadedState());
  // }

  // uploadItemInfo(
  //     itemId, itemName, itemDescription, itemIngredients, itemNuetrations) {
  //   itemsRepository
  //       .uploadItemInfo(
  //           itemId, itemName, itemDescription, itemIngredients, itemNuetrations)
  //       .then((value) {
  //     if (value) {
  //       Fluttertoast.showToast(
  //         msg: 'تم حفظ التعديلات',
  //         toastLength: Toast.LENGTH_SHORT, // length
  //       );
  //     } else {
  //       Fluttertoast.showToast(
  //         msg: 'لم يتم الحفظ، حاول لاحقاً',
  //         toastLength: Toast.LENGTH_SHORT, // length
  //       );
  //     }
  //   }).catchError((e) {
  //     Fluttertoast.showToast(
  //       msg: 'لم يتم الحفظ، حاول لاحقاً',
  //       toastLength: Toast.LENGTH_SHORT, // length
  //     );
  //   });
  // }

  List<Meal> getItemsByCategory(categoryName) {
    return meals.where((element) {
      return element.categoryName == categoryName;
    }).toList();
  }

  getItems(grouped, groupedByCompany) async {
    // print('inside getItems');
    // print(grouped);
    List<Meal> meals;
    int count = 0;
    if (state is MealsReadyState || state is EmptyItemListState) {
      // print(state);
      //
      // print(categories.length);
      // print(categories.first.categoryName);
      // print(this.items.first.itemName);
      // print(count);
      if (grouped == true) {
        if (groupedByCompany == true) {
          meals = getItemsByCompany(categories.first.categoryTitle);
        } else {
          meals = getItemsByCategory(categories.first.categoryTitle);
        }
      } else {
        meals = this.meals;
      }

      emit(MealsLoadedState(meals));
    }
  }

  getItemsbyChipSelect(groupName, groupedByCompany) {
    print(groupName);
    print(groupedByCompany);
    List<Meal> meals = groupedByCompany
        ? getItemsByCompany(groupName)
        : getItemsByCategory(groupName);

    if (meals.isEmpty) {
      emit(EmptyItemListState());
    } else {
      emit(MealsLoadedState(meals));
    }
  }

  List<Meal> searchForItems(name, List<Meal> preItems, fav) {
    List<Meal> searchedItems;
    preSearchItems = preItems;
    if (state is MealsLoadedState) {
      if (fav) {
        searchedItems =
            favItems.where((meal) => meal.mealTitle.contains(name)).toList();
      } else {
        searchedItems =
            meals.where((meal) => meal.mealTitle.contains(name)).toList();
      }
      return searchedItems;
    } else {
      return [];
    }
  }

  showFav(bool fav, List<String> favitemsCodes) {
    favItems = meals
        .where((element) => favitemsCodes.contains(element.mealCode))
        .toList();
    if (state is MealsLoadedState) {
      if (fav) {
        emit(MealsLoadedState(favItems));
      } else {
        emit(MealsLoadedState(meals));
      }
    }
  }

  showSelectedItems(int selected, List<String> offerItemsCodes, favitemsCodes) {
    // offerItems = items
    //     .where((element) => offerItemsCodes.contains(element.itemCode))
    //     .toList();
    favItems = meals
        .where((element) => favitemsCodes.contains(element.mealCode))
        .toList();
    if (state is MealsLoadedState) {
      emit(MealsLoadingState());
      if (selected == 0) {
        emit(MealsLoadedState(meals));
      } else if (selected == 1) {
        emit(MealsLoadedState(favItems));
      }
    }
  }

  toggleFav(Meal meal, fav, insideFav) {
    if (fav) {
      // meal.isFav = true;

      favItems.add(meal);
      print(favItems.length);
    } else {
      // meal.isFav = false;

      favItems.remove(meal);

      if (insideFav) {
        emit(MealsLoadingState());
        emit(MealsLoadedState(favItems));
      }
      print(favItems.length);
    }
  }

  Meal getItemDataByItemCode(itemCode) {
    return meals.firstWhere((element) => element.mealCode == itemCode);
  }

//
// Meal getItemUnitByItemUnitName(itemCode, String itemUnitName) {
//   late MealSize selectedSize;
//   Meal meal = meals.firstWhere((element) => element.mealCode == itemCode);
//   selectedSize = meals.mealSizes
//       .firstWhere((element) => element.unitName == itemUnitName);
//   return selectedUnit;
// }
  getMealSizeBySizeName() {}
  addTopping() {}
}
