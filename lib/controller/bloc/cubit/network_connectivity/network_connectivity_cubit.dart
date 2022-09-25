import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'network_connectivity_state.dart';

class NetworkConnectivityCubit extends Cubit<NetworkConnectivityState> {
  NetworkConnectivityCubit({required this.connectivity})
      : super(NetworkConnectivityInitial()) {}
  checkConnection() {
    print('insideCheckConnection');
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      print(connectivityResult);
      _checkResult(connectivityResult);
    });
  }

  _checkResult(ConnectivityResult connectivityResult) async {
    bool isConnected = false;
    if (connectivityResult == ConnectivityResult.none) {
      emitNetworkDisconnected();
    } else {
      try {
        final result = await InternetAddress.lookup('example.com');
        print(result.isNotEmpty);
        isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } on SocketException catch (_) {
        print('notConnected');
        isConnected = false;
        emitNetworkDisconnected();
      }
      print('connected');
      isConnected = true;
      if (isConnected) {
        if (connectivityResult == ConnectivityResult.wifi) {
          emitNetworkConnected(ConnectionType.wifi);
        } else if (connectivityResult == ConnectivityResult.mobile) {
          emitNetworkConnected(ConnectionType.mobile);
        } else if (connectivityResult == ConnectivityResult.ethernet) {
          emitNetworkConnected(ConnectionType.ethernet);
        }
      }
    }
  }

  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;
  void emitNetworkConnected(ConnectionType _connectionType) =>
      emit(ConnectedState(connectionType: _connectionType));

  void emitNetworkDisconnected() => emit(DisconnectedState());

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
