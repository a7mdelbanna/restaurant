import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../data/model/cart.dart';
import '../../../../data/model/order_model.dart';
import '../../../../data/repositories/order_repository.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  late final OrderRepository orderRepository;

  late final String name;
  late final bool success = false;
  OrdersBloc(this.orderRepository, this.name) : super(OrdersInitialState()) {
    on<LoadOrdersEvent>(_onLoadOrders);
    on<AddOrderEvent>(_onAddOrder);
    on<RemoveOrderEvent>(_onRemoveOrder);
    on<EditOrderEvent>(_onEditOrder);
  }

  void _onLoadOrders(event, Emitter<OrdersState> emit) async {
    List<Order> orders = [];

    emit(OrdersLoadingState());
    try {
      orders = await orderRepository.getAllOrders(event.userId);

      if (orders.isEmpty) {
        print('emptyOrders');
        emit(
          OrdersEmptyState(),
        );
      } else {
        orders = orders.reversed.toList();
        print('notEmpty');
        emit(OrdersLoadedState(orders: Orders(orders: orders)));
      }
    } catch (_) {
      print('ordersLoaderror');
      emit(OrdersErrorState('errorOnload'));
    }
  }

  _onAddOrder(event, Emitter<OrdersState> emit) async {
    List<Order> preAddOrders = [];
    final state = this.state;
    print('insideAddOrderBloc');
    if (state is OrdersLoadedState) {
      preAddOrders = state.orders.orders;
    } else if (state is OrdersEmptyState) {
      preAddOrders = [];
    }
    final ordersRef = FirebaseFirestore.instance.collection('Orders').doc();

    await ordersRef.set(
      orderToJson(
        delAddress: event.delAddress,
        orderId: ordersRef.id,
        firstName: event.firstName,
        phone: event.phone,
        total: event.total,
        del: event.del,
        dateTime: event.dateTime,
        items: event.items,
        userId: event.userId,
        net: event.net,
        no: event.no,
        ser: event.ser,
        totalTax: event.totalTax,
        totalOfferDis: event.totalOfferDis,
        state: 0,
      ),
    );

    if (ordersRef.id == '') {
      emit(
        OperationNotCompletedState('Error ordering, try again. '),
      );
      final snackBar = SnackBar(
        content: Text(
          'Error ordering, try again. ',
        ),
      );
      ScaffoldMessenger.of(event.context).showSnackBar(snackBar);
      emit(OrdersLoadedState(orders: Orders(orders: preAddOrders)));
    } else if (ordersRef.toString().isNotEmpty) {
      print('insideOrderBlocAddOrderrrrrr');

      emit(const OperationCompletedState());
      List<Order> newOrdersList = preAddOrders;
      newOrdersList.add(Order(
        state: 0,
        delAddress: event.delAddress,
        totalOfferDis: event.totalOfferDis,
        totalTax: event.totalTax,
        firstName: event.firstName,
        userId: event.userId,
        phone: event.phone,
        del: event.del,
        id: ordersRef.id,
        total: event.total,
        itemsList: event.items,
        dateTime: DateTime.parse(event.dateTime),
        net: event.net,
        no: event.no,
        ser: event.ser,
      ));
      emit(
        OrdersLoadedState(
          orders: Orders(
            orders: newOrdersList,
          ),
        ),
      );
      final snackBar = SnackBar(
        content: Text(
          'Order received successfully',
        ),
      );
      ScaffoldMessenger.of(event.context).showSnackBar(snackBar);

      // }).catchError((error) {
      //   final snackBar = SnackBar(
      //     content: Text(
      //       'خطأ اثناء إرسال الطلب، حاول مرة آخرى',
      //       textDirection: TextDirection.rtl,
      //     ),
      //   );
      //   ScaffoldMessenger.of(event.context).showSnackBar(snackBar);
      // });
    }
  }

  void _onRemoveOrder(event, Emitter<OrdersState> emit) async {
    final state = this.state;
    Order order = event.order;
    late final bool checkServerOrderRemove;
    if (state is OrdersLoadedState) {
      try {
        if (order.del == false) {
          checkServerOrderRemove = await orderRepository.removeOrder(
              userId: event.username, orderId: order.id);

          if (checkServerOrderRemove) {
            emit(
              OrdersLoadedState(
                orders: Orders(
                  orders: List.from(state.orders.orders)..remove(event.order),
                ),
              ),
            );
          } else {
            emit(OrdersErrorState('خطأ أثناء عملية الحذف'));
            Future.delayed(const Duration(seconds: 3));
            emit(
                OrdersLoadedState(orders: Orders(orders: state.orders.orders)));
          }
        } else {
          emit(OrdersErrorState('لا يمكنك حذف طلب تمت الموافقة عليه'));
          Future.delayed(const Duration(seconds: 3));
          emit(OrdersLoadedState(orders: Orders(orders: state.orders.orders)));
        }
      } on Exception {
        emit(OrdersErrorState('errorRemoving'));
      }
    }
  }

  void _onEditOrder(event, Emitter<OrdersState> emit) {
    final state = this.state;
    if (state is OrdersLoadedState) {
      try {
        // cartRepository.removeItem(event.cartItem, 'omar');
        emit(OrdersLoadedState(
            orders: Orders(
                orders: List.from(state.orders.orders)..remove(event.order))));
      } on Exception {
        emit(OrdersErrorState('errorEditing'));
      }
    }
  }

  Future onSuccess() async {
    await Future.delayed(const Duration(seconds: 10));
  }

// void _onEditOrder(event, Emitter<OrdersState> emit) {
//   final state = this.state;
//   if (state is OrdersLoadedState) {
//     try {
//       List<Orders> orders =
//           List.from(state.orders.orders).removeAt(event.index);
//       orders.insert(event.index, event.cartItem);
//       orderRepository.updateItem(event.cartItem, event.username);
//       emit(CartLoadedState(cart: Cart(cartItems: items)));
//     } on Exception {
//       emit(CartErrorState());
//     }
//   }
// }
}
