part of 'categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesLoadedState extends CategoriesState {
  const CategoriesLoadedState(this.categories);

  final List<Category> categories;
  @override
  List<Object> get props => [categories];
}

class CategoriesErrorState extends CategoriesState {
  const CategoriesErrorState(this.errorMessage);
  final String errorMessage;
  @override
  List<Object> get props => [errorMessage];
}

class NoCategoriesState extends CategoriesState {
  @override
  List<Object> get props => [];
}
class SelectedCategoryState extends CategoriesState{
final Category category;
const SelectedCategoryState(this.category);
  @override
  List<Object> get props => [];
}
