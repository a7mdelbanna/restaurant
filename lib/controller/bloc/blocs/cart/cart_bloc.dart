import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../data/model/cart.dart';
import '../../../../data/repositories/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepository cartRepository;
  List<CartItem> items = [];

  CartBloc(this.cartRepository) : super(CartEmptyState()) {
    // on<LoadCartEvent>(_onLoadFromDB);
    on<AddProductEvent>(_onAddProduct);
    on<RemoveProductEvent>(_onRemoveProduct);
    on<EditProductEvent>(_onEditProduct);
    on<ClearCartEvent>(_onClearCart);
    on<ChangeCartItemQuantity>(_onChangeCartItemQuantity);
    on<AddMultiProductEvent>(_onAddMultiProductEvent);
    on<UpdateCartAfterPriceQuantityUpdate>(
        _onUpdateCartAfterPriceQuantityUpdate);
    //on<CheckPricesUpdates>(_onCheckPricesUpdates);
  }
  // void _onLoadFromDB(event, Emitter<CartState> emit) async {
  //   emit(CartLoadingState());
  //   try {
  //     items = await cartRepository.getItems(event.uid);
  //
  //     items.isEmpty
  //         ? emit(CartEmptyState())
  //         : emit(CartLoadedState(cart: Cart(cartItems: items)));
  //   } catch (e) {
  //     emit(CartErrorState());
  //   }
  // }

  // _onCheckPricesUpdates(event, Emitter<CartState> emit) {
  //   List<CartItem> newCartPrices = event.newCartItems;
  //   List<CartItem> oldCartPrices = event.cartItems;
  //   emit(CartLoadingState());
  //   for (CartItem newCartItem in newCartPrices) {
  //     for (CartItem oldCartItem in oldCartPrices) {
  //       if (newCartItem.id == oldCartItem.id) {
  //         oldCartItem.price = newCartItem.price;
  //       }
  //     }
  //   }
  // }

  void _onAddProduct(event, Emitter<CartState> emit) {
    final state = this.state;

    List<CartItem> items;
    if (state is CartLoadedState) {
      List<CartItem> oldList = state.cart.cartItems;
      try {
        emit(CartLoadingState());
        // cartRepository.addItem(event.cartItem, event.uid);
        items = List.from(oldList)..add(event.cartItem);
        print('itemAddedTolocaal');
        emit(
          CartLoadedState(
            cart: Cart(
              cartItems: items,
            ),
          ),
        );
        print('itemAdded');
      } on Exception {
        emit(CartErrorState());
      }
    }
    if (state is CartEmptyState) {
      try {
        // cartRepository.addItem(event.cartItem, event.uid);
        print('itemAddedTolocaal');
        emit(
          CartLoadedState(
            cart: Cart(
              cartItems: List.from(state.cart.cartItems)..add(event.cartItem),
            ),
          ),
        );
        print('itemAdded');
      } on Exception {
        emit(CartErrorState());
      }
    }
  }

  void _onRemoveProduct(event, Emitter<CartState> emit) {
    final state = this.state;
    final List<CartItem> items;
    CartItem item;
    if (state is CartLoadedState) {
      try {
        // cartRepository.removeItem(event.cartItem, event.uid);
        item = event.cartItem;
        print(item.title);
        print(event.index);
        print('itemRemoveddfromlocaal');
        items = List.from(state.cart.cartItems)..removeAt(event.index);

        items.isEmpty
            ? emit(CartEmptyState())
            : emit(CartLoadedState(cart: Cart(cartItems: items)));
      } on Exception {
        emit(CartErrorState());
      }
    }
  }

  void _onEditProduct(event, Emitter<CartState> emit) {
    final state = this.state;
    final List<CartItem> items;
    if (state is CartLoadedState) {
      try {
        CartItem item = List.from(state.cart.cartItems).elementAt(event.index);
        items = List.from(state.cart.cartItems);
        items.removeAt(event.index);
        items.insert(event.index, event.cartItem);
        emit(CartLoadingState());
        // cartRepository.updateItem(event.cartItem, event.uid);
        emit(CartLoadedState(cart: Cart(cartItems: items)));
      } on Exception {
        emit(CartErrorState());
      }
    }
  }

  Future _onClearCart(event, Emitter<CartState> emit) async {
    try {
      emit(CartLoadingState());
      // await cartRepository.clearData(event.uid);
      emit(CartEmptyState(cart: Cart(cartItems: [])));
    } catch (_) {}
  }

  _onChangeCartItemQuantity(event, Emitter<CartState> emit) {
    final state = this.state;
    CartItem item;
    List<CartItem> items;
    item = event.cartItem;
    print(item.quantity);

    if (state is CartLoadedState) {
      if (event.add) {
        item.quantity = item.quantity + 1;
        item.itemTotal = item.quantity * item.price!;
        items = List.from(state.cart.cartItems)..removeAt(event.index);
        print(items.length);
        items.insert(event.index, event.cartItem);
        // cartRepository.updateItem(event.cartItem, event.uid);
        print(items.length);
        print(items.first.quantity);
        emit(CartItemEditting());
        //cartRepository.updateItem(event.cartItem, event.username);
        emit(CartLoadedState(cart: Cart(cartItems: items)));
      } else {
        if (item.quantity == 1) {
          items = List.from(state.cart.cartItems)..removeAt(event.index);
          // cartRepository.removeItem(event.cartItem, event.uid);
          emit(CartItemEditting());
          if (items.isEmpty) {
            emit(CartEmptyState(cart: Cart(cartItems: [])));
          } else {
            emit(CartLoadedState(cart: Cart(cartItems: items)));
          }
          //cartRepository.updateItem(event.cartItem, event.username);

        } else {
          item.quantity -= 1;

          item.itemTotal = item.quantity * item.price!;
          print(item.quantity);
          print('insideSub');
          items = List.from(state.cart.cartItems)..removeAt(event.index);
          print(items.length);
          items.insert(event.index, event.cartItem);
          // cartRepository.updateItem(event.cartItem, event.uid);
          print(items.length);
          print(items.first.quantity);
          emit(CartItemEditting());
          //cartRepository.updateItem(event.cartItem, event.username);
          emit(CartLoadedState(cart: Cart(cartItems: items)));
        }
      }
    }
  }

  _onAddMultiProductEvent(event, Emitter<CartState> emit) {
    final state = this.state;
    final bool isEmpty = event.isEmpty;
    final bool removePre = event.removePre;
    List<CartItem> items = [];
    List<CartItem> tempList = event.cartItems;
    emit(CartLoadingState());
    if (state is CartLoadedState && removePre == false) {
      try {
        items = List.from(state.cart.cartItems)..addAll(tempList);

        if (items.isEmpty) {
          emit(CartEmptyState(cart: Cart(cartItems: [])));
        } else {
          emit(
            CartLoadedState(
              cart: Cart(
                cartItems: items,
              ),
            ),
          );
          // for (var element in tempList) {
          //   cartRepository.addItem(element, event.uid);
          // }
        }
        Fluttertoast.showToast(
          msg: 'Order items copied to cart ',
          toastLength: Toast.LENGTH_SHORT, // length
        );
        print('itemAdded');
      } on Exception {
        emit(CartErrorState());
      }
    } else if (state is CartLoadedState && removePre == true) {
      items.addAll(tempList);
      emit(CartEmptyState(
        cart: Cart(cartItems: []),
      ));
      // cartRepository.clearData(event.uid);

      if (items.isEmpty) {
        emit(
          CartEmptyState(cart: Cart(cartItems: [])),
        );
      } else {
        emit(
          CartLoadedState(cart: Cart(cartItems: items)),
        );
        Fluttertoast.showToast(
          msg: 'Order items copied to cart ',
          toastLength: Toast.LENGTH_SHORT, // length
        );
      }
    }
    if (isEmpty) {
      try {
        items.addAll(tempList);
        print('itemsAdded');
        emit(CartLoadedState(cart: Cart(cartItems: items)));
        // for (var element in tempList) {
        //   cartRepository.addItem(element, event.uid);
        // }
      } on Exception {
        emit(CartErrorState());
      }
    }
  }

  _onUpdateCartAfterPriceQuantityUpdate(event, Emitter<CartState> emit) {
    final state = this.state;
    List<CartItem> items = [];
    List<CartItem> tempList = event.cartItems;
    emit(CartLoadingState());
    if (state is CartLoadedState) {
      items.addAll(tempList);

      emit(CartEmptyState(
        cart: Cart(cartItems: []),
      ));
      // cartRepository.clearData(event.uid);
      //
      // for (var element in tempList) {
      //   cartRepository.addItem(element, event.uid);
      // }
      emit(
        CartLoadedState(cart: Cart(cartItems: items)),
      );
    }
  }
}
