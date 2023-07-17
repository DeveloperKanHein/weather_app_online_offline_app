import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkConnection() async {
  bool isAvailableNetwork = false;
  final connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    isAvailableNetwork = true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    isAvailableNetwork = true;
  } else if (connectivityResult == ConnectivityResult.ethernet) {
    isAvailableNetwork = true;
  } else if (connectivityResult == ConnectivityResult.vpn) {
    isAvailableNetwork = true;
  } else if (connectivityResult == ConnectivityResult.bluetooth) {
    isAvailableNetwork = true;
  } else if (connectivityResult == ConnectivityResult.other) {
    isAvailableNetwork = true;
  } else if (connectivityResult == ConnectivityResult.none) {
    isAvailableNetwork = false;
  }
  return isAvailableNetwork;
}