import '../exceptions.dart';
import '../model/meal.dart';
import '../webservices/meals_web_services.dart';

class MealsRepository {
  MealsWebServices mealsWebServices;

  MealsRepository(this.mealsWebServices);

  Future<List<Meal>> getAllItems() async {
    try {
      final meals = await mealsWebServices.getAllItemsFirebaseSDK();

      final List<Meal> loadedMeals = [];
      List<MealSize> sizes = [];
      if (meals == null) {
        return [];
      }
      meals.forEach((itemId, value) {
        value.forEach((key, item) {
          item.forEach((key, value) {
            if (key == "mealSizes") {
              sizes = formatSizes(value);
            }
          });
          Meal meal = Meal(
              mealId: item['mealId'],
              isVegan: false,
              mealDescription: item['mealDescription'],
              mealIngredients: item['mealIngredients'],
              mealImageUrl: item['mealImageUrl'],
              mealTitle: item['mealTitle'],
              mealCode: item['mealCode'],
              mealSizes: sizes,
              categoryId: item['categoryId'],
              categoryName: item['categoryName']);

          loadedMeals.add(meal);
        });
      });

      return loadedMeals;
    } on TimeOutException catch (e) {
      rethrow;
    } on DataException catch (e) {
      rethrow;
    }
  }

  List<MealSize> formatSizes(value) {
    List<MealSize> mealSizes = [];
    value.forEach((unitName, unit) {
      MealSize mealSize = MealSize(
          sizeId: unit['sizeId'],
          sizeName: unit['sizeName'],
          sizePrice: unit['sizePrice']);

      mealSizes.add(mealSize);
    });
    // print(units.length.toString());
    return mealSizes;
  }

  // Future uploadItemImage(itemId, itemName, imageUrl) async {
  //   await itemsWebServices
  //       .uploadItemImage(itemId, itemName, imageUrl)
  //       .then((value) {
  //     if (value) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   }).catchError((e) {
  //     return false;
  //   });
  // }

  // Future uploadItemInfo(itemId, itemName, itemDescription, itemIngredients,
  //     itemNuetrations) async {
  //   await itemsWebServices
  //       .uploadItemInfo(
  //           itemId, itemName, itemDescription, itemIngredients, itemNuetrations)
  //       .then((value) {
  //     if (value) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   }).catchError((e) {
  //     return false;
  //   });
  // }
}
