import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/model/category.dart';
import '../../../../data/repositories/categories_repository.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesRepository categoriesRepository;
  CategoriesCubit(this.categoriesRepository) : super(CategoriesInitial());
  void getAllCategories() {
    try {
      categoriesRepository.getAllCategories().then((categories) {
        categories.isEmpty
            ? emit(NoCategoriesState())
            : emit(CategoriesLoadedState(categories));
      });
    } catch (e) {
      emit(CategoriesErrorState(e.toString()));
    }
  }

  selectCategory(Category category) {
    emit(SelectedCategoryState(category));
  }
}
