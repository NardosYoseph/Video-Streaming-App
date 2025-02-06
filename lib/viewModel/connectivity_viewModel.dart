import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:video_streaming_app/models/connectivity_status.dart';

class ConnectivityNotifier extends StateNotifier<ConnectivityStatus> {
  ConnectivityNotifier() : super(ConnectivityStatus.online) {
    _monitorNetwork();
  }

  void _monitorNetwork() {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      if (results.contains(ConnectivityResult)) {
        state = ConnectivityStatus.offline;
      } else {
        state = ConnectivityStatus.online;
      }
    });
  }
}

// Global Provider for network status
final connectivityProvider = StateNotifierProvider<ConnectivityNotifier, ConnectivityStatus>(
  (ref) => ConnectivityNotifier(),
);
