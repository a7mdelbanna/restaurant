part of 'network_connectivity_cubit.dart';

enum ConnectionType {
  wifi,
  mobile,
  ethernet,
}

abstract class NetworkConnectivityState extends Equatable {
  const NetworkConnectivityState();
}

class NetworkConnectivityInitial extends NetworkConnectivityState {
  @override
  List<Object> get props => [];
}

class ConnectedState extends NetworkConnectivityState {
  final ConnectionType connectionType;

  const ConnectedState({required this.connectionType});
  @override
  List<Object> get props => [];
}

class DisconnectedState extends NetworkConnectivityState {
  @override
  List<Object> get props => [];
}
