part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartEmptyState extends CartState {
  Cart cart;
  CartEmptyState({this.cart = const Cart()});
  @override
  List<Object> get props => [cart];
}

class CartLoadingState extends CartState {
  @override
  List<Object> get props => [];
}

// class CartLoadFromDB extends CartState {
//   Cart cart;
//   CartLoadFromDB(this.cart);
//   @override
//   List<Object> get props => [cart];
// }

class CartLoadedState extends CartState {
  late Cart cart;
  CartLoadedState({this.cart = const Cart()});
  CartLoadedState copyWith({Cart? cart}) =>
      CartLoadedState(cart: cart ?? this.cart);

  @override
  List<Object> get props => [cart];
}

class CartErrorState extends CartState {
  @override
  List<Object> get props => [];
}

class CartItemEditting extends CartState {
  @override
  List<Object> get props => [];
}
