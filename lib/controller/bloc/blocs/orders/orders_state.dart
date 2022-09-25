part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();
}

class OrdersInitialState extends OrdersState {
  @override
  List<Object> get props => [];
}

class OrdersLoadingState extends OrdersState {
  @override
  List<Object> get props => [];
}

class OperationCompletedState extends OrdersState {
  const OperationCompletedState();
  @override
  List<Object> get props => [];
}

class OperationNotCompletedState extends OrdersState {
  String operationError;
  OperationNotCompletedState(this.operationError);
  @override
  List<Object> get props => [operationError];
}

class OrdersLoadedState extends OrdersState {
  Orders orders;
  OrdersLoadedState({this.orders = const Orders()});
  @override
  List<Object> get props => [orders];
}

class OrdersEmptyState extends OrdersState {
  Orders orders;
  OrdersEmptyState({this.orders = const Orders()});
  @override
  List<Object> get props => [orders];
}

class OrdersErrorState extends OrdersState {
  String error;
  OrdersErrorState(this.error);
  @override
  List<Object> get props => [error];
}
