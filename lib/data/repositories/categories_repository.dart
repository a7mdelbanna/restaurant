import '../model/category.dart';
import '../webservices/categories_web_services.dart';

class CategoriesRepository {
  CategoriesWebServices categoriesWebServices;

  CategoriesRepository(this.categoriesWebServices);

  Future<List<Category>> getAllCategories() async {
    try {
      final categories =
          await categoriesWebServices.getAllCategoriesFirebaseSDK();

      final List<Category> loadedCategories = [];
      Category category;
      if (categories == null) {
        return [];
      }
      categories.forEach((colId, value) {
        value.forEach((key, cat) {
          category = Category.fromJson(cat);
          loadedCategories.add(category);
        });
      });

      return loadedCategories;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
