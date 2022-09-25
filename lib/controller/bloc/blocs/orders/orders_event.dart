part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();
}

class LoadOrdersEvent extends OrdersEvent {
  const LoadOrdersEvent({required this.userId});
  final String userId;
  @override
  List<Object> get props => [userId];
}

class AddOrderEvent extends OrdersEvent {
  List<CartItem> items;
  String dateTime;
  bool del;
  double total;
  String phone;
  String firstName;
  double totalTax;
  double totalOfferDis;
  double net;
  double ser;
  double no;
  String userId;
  String delAddress;
  final context;
  AddOrderEvent({
    required this.delAddress,
    required this.context,
    required this.no,
    required this.net,
    required this.ser,
    required this.totalTax,
    required this.total,
    required this.items,
    required this.del,
    required this.dateTime,
    required this.firstName,
    required this.phone,
    required this.userId,
    required this.totalOfferDis,
  });
  @override
  List<Object> get props => [
        delAddress,
        context,
        userId,
        items,
        firstName,
        dateTime,
        del,
        total,
        phone,
        ser,
        net,
        no,
        totalTax,
        totalOfferDis
      ];
}

class RemoveOrderEvent extends OrdersEvent {
  Order order;

  String username;
  RemoveOrderEvent(this.order, this.username);
  @override
  List<Object> get props => [order, username];
}

class EditOrderEvent extends OrdersEvent {
  Order order;
  String username;
  EditOrderEvent(this.order, this.username);
  @override
  List<Object> get props => [order, username];
}
