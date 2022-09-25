class Meal {
  final String mealId;
  final String mealImageUrl;
  final String mealTitle;
  final String categoryName;
  final String categoryId;
  final String mealDescription;
  final List<String> mealIngredients;
  final String mealCode;
  final bool isVegan;

  final List<MealSize> mealSizes;

  Meal({
    required this.categoryName,
    required this.categoryId,
    required this.mealCode,
    required this.mealDescription,
    required this.mealId,
    required this.mealSizes,
    required this.mealImageUrl,
    required this.mealIngredients,
    required this.isVegan,
    required this.mealTitle,
  });
}

class MealSize {
  MealSize({
    required this.sizeId,
    required this.sizeName,
    required this.sizePrice,
  });

  late String sizeId;
  late String sizeName;
  late double sizePrice;
  MealSize.fromJson(Map<String, dynamic> json) {
    sizeId = json['sizeId'];
    sizeName = json['sizeName'];
    sizePrice = json['sizePrice'];
  }
}
