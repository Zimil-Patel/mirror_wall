import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../provider/home_provider.dart';

class WebViewContainer extends StatefulWidget {
  final HomeProvider providerTrue;
  final HomeProvider providerFalse;

  const WebViewContainer({
    super.key,
    required this.providerTrue,
    required this.providerFalse,
  });

  @override
  WebViewContainerState createState() => WebViewContainerState();
}

class WebViewContainerState extends State<WebViewContainer> {
  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      onRefresh: () {
        widget.providerTrue.webController.reload();
      },
    );
  }

  @override
  void dispose() {
    pullToRefreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OnlineContent(
      providerTrue: widget.providerTrue,
      providerFalse: widget.providerFalse,
      pullToRefreshController: pullToRefreshController,
    );
  }
}


class OnlineContent extends StatelessWidget {
  const OnlineContent({
    super.key,
    required this.providerTrue,
    required this.providerFalse,
    required this.pullToRefreshController,
  });

  final HomeProvider providerTrue;
  final HomeProvider providerFalse;
  final PullToRefreshController pullToRefreshController;

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
            pullToRefreshController.endRefreshing();
          },
          // URL LOADING OVERRIDE
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            final uri = navigationAction.request.url;
            if (uri != null && uri.toString() != 'https://www.${providerTrue.selectedEngine}.com/') {
              providerFalse.currentUrl = uri.toString();
            }
            return NavigationActionPolicy.ALLOW;
          },
          pullToRefreshController: pullToRefreshController, // Add the PullToRefreshController here
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
