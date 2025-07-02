import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// Create a StreamProvider that listens to connectivity changes
final connectivityProvider = StreamProvider<ConnectivityResult>((ref) {
  final connectivity = Connectivity();
  return connectivity.onConnectivityChanged.asyncMap((results) {
    // Since onConnectivityChanged returns a List, we are selecting the first result.
    // This might be the reason for the stream being a list. We're assuming one connectivity result here.
    return results.isNotEmpty ? results.first : ConnectivityResult.none;
  });
});
