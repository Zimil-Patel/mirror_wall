
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/screens/view/components/progress_bar.dart';
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

          // PASS INITIAL URL HERE
          initialUrlRequest: URLRequest(
            url: WebUri('https://www.google.com/'),
          ),


          // ON WEB VIEW CRATED
          onWebViewCreated: (controller) {
            providerFalse.setWebController(controller);
          },

          // UPDATE PROGRESS VALUE HERE
          onProgressChanged: (controller, progress) {
            providerFalse.updateProgressValue(progress);
          },


          // ACTIONS AFTER ON LOAD
          onLoadStop: (controller, url) async {
            await providerFalse.endRefreshing();

          },


          // ACTION ON TITLE CHANGED
          onTitleChanged: (controller, title) async {


            // FETCH TITLE AND URL
            await providerFalse.getTitleAndUrl();

            // ADD TO HISTORY
            providerFalse.addToHistoryList();

            // CHECK CAN NAVIGATE
            await providerFalse.checkCanGoBackForwardHome();

            // CHECK IF EXISTING IN BOOKMARK OR NOT
            providerFalse.checkIfExistInBookMark();
          },


          // PULL TO REFRESH CONTROLLER
          pullToRefreshController: providerTrue.pullToRefreshController,

        ),


        // WEBSITE LOADING PROGRESS INDICATOR
        if (providerTrue.progressValue < 1)
          ProgressBar(providerTrue: providerTrue),
      ],
    );
  }
}


