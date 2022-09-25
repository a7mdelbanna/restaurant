part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object> get props => [];
}

class LoadCartEvent extends CartEvent {
  String uid;
  LoadCartEvent(this.uid);
  @override
  List<Object> get props => [uid];
}

class SuccessLunch extends CartEvent {
  String uid;
  SuccessLunch(this.uid);
  @override
  List<Object> get props => [uid];
}

// class LoadCartFromDBEvent extends CartEvent {
//    String username;
//   LoadCartFromDBEvent(this.username);
//   @override
//   List<Object> get props => [];
// }
class AddProductEvent extends CartEvent {
  final CartItem cartItem;
  final String uid;

  const AddProductEvent(this.cartItem, this.uid);
  @override
  List<Object> get props => [cartItem, uid];
}

class AddMultiProductEvent extends CartEvent {
  final List<CartItem> cartItems;
  final String uid;
  final bool removePre;
  final bool isEmpty;
  final bool fromEdit;
  const AddMultiProductEvent(
      this.cartItems, this.uid, this.removePre, this.isEmpty, this.fromEdit);
  @override
  List<Object> get props => [cartItems, uid, removePre, isEmpty, fromEdit];
}

class UpdateCartAfterPriceQuantityUpdate extends CartEvent {
  final List<CartItem> cartItems;
  final String uid;

  const UpdateCartAfterPriceQuantityUpdate(
    this.cartItems,
    this.uid,
  );
  @override
  List<Object> get props => [
        cartItems,
        uid,
      ];
}

class CheckPricesUpdates extends CartEvent {
  final List<CartItem> cartItems;
  final List<CartItem> newCartItems;
  final String uid;

  const CheckPricesUpdates(
    this.cartItems,
    this.uid,
    this.newCartItems,
  );
  @override
  List<Object> get props => [
        cartItems,
        uid,
        newCartItems,
      ];
}

class RemoveProductEvent extends CartEvent {
  final int index;
  final CartItem cartItem;
  final String uid;
  const RemoveProductEvent(this.index, this.cartItem, this.uid);
  @override
  List<Object> get props => [index, cartItem, uid];
}

class EditProductEvent extends CartEvent {
  final CartItem cartItem;
  final String uid;
  final int index;
  const EditProductEvent(
    this.cartItem,
    this.uid,
    this.index,
  );
  @override
  List<Object> get props => [cartItem, uid, index];
}

class ClearCartEvent extends CartEvent {
  final String uid;
  const ClearCartEvent(this.uid);

  @override
  List<Object> get props => [uid];
}

class ChangeCartItemQuantity extends CartEvent {
  final CartItem cartItem;
  final bool add;
  final int index;

  const ChangeCartItemQuantity(
    this.cartItem,
    this.add,
    this.index,
  );
  @override
  List<Object> get props => [
        cartItem,
        add,
        index,
      ];
}
