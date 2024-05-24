import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../provider/home_provider.dart';
import 'offline_content.dart';
import 'online_content.dart';


class WebViewBox extends StatelessWidget {
  const WebViewBox({
    super.key,
    required this.providerTrue,
    required this.providerFalse,
  });

  final HomeProvider providerTrue;
  final HomeProvider providerFalse;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          if (snapshot.data!.contains(ConnectivityResult.mobile) || snapshot.data!.contains(ConnectivityResult.wifi)) {
            return OnlineContent(providerTrue: providerTrue, providerFalse: providerFalse);
          } else {
            return const OfflineContent();
          }
        }

      ),
    );
  }
}




