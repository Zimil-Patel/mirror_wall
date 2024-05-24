import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../provider/home_provider.dart';

class OnlineContent extends StatelessWidget {
  const OnlineContent({
    super.key,
    required this.providerTrue,
    required this.providerFalse,
  });

  final HomeProvider providerTrue;
  final HomeProvider providerFalse;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // IN APP WEB VIEW
        InAppWebView(
          key: providerTrue.webKey,
          // INITIAL URL
          initialUrlRequest: URLRequest(
            url: WebUri('https://www.${providerTrue.selectedEngine}.com/'),
          ),

          // ON CREATED
          onWebViewCreated: (controller) {
            providerTrue.webController = controller;
          },

          // PROGRESS TRACK
          onProgressChanged: (controller, progress) =>
              providerFalse.updateProgressValue(progress),

          // ON LOAD STOP
          onLoadStop: (controller, url) {
            providerFalse.updateState();
          },
        ),

        // WEBSITE LOADING PROGRESS INDICATOR
        if (providerTrue.progressValue < 1)
          Align(
            alignment: Alignment.bottomCenter,
            child: LinearProgressIndicator(
              value: providerTrue.progressValue,
              minHeight: 2,
              color: Colors.blueAccent,
            ),
          ),
      ],
    );
  }
}
