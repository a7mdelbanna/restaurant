part of 'meals_cubit.dart';

abstract class MealState extends Equatable {
  const MealState();
}

class MealsInitial extends MealState {
  @override
  List<Object> get props => [];
}

class MealsLoadingState extends MealState {
  @override
  List<Object> get props => [];
}

class MealsShouldUpdateState extends MealState {
  @override
  List<Object> get props => [];
}

class MealsLoadedState extends MealState {
  const MealsLoadedState(this.meals);

  final List<Meal> meals;

  @override
  List<Object> get props => [meals];
}

class MealsTimeoutErrorState extends MealState {
  late String errorMessage;
  MealsTimeoutErrorState(this.errorMessage);
  printError() {
    print(errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}

class MealsDataErrorState extends MealState {
  late String errorMessage;
  MealsDataErrorState(this.errorMessage);
  printError() {
    print(errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}

class MealsGroupedByState extends MealState {
  const MealsGroupedByState(this.meals);

  final List<Meal> meals;

  @override
  List<Object> get props => [meals];
}

class PressedCategoryMealState extends MealState {
  final List<Meal> meals;
  const PressedCategoryMealState(this.meals);
  @override
  List<Object> get props => [meals];
}

class MealsReadyState extends MealState {
  @override
  List<Object> get props => [];
}

class EmptyItemListState extends MealState {
  @override
  List<Object> get props => [];
}
