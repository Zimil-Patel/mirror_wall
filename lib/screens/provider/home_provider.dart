import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomeProvider extends ChangeNotifier {
  TextEditingController txtSearch = TextEditingController();
  late InAppWebViewController webController;
  String searchValue = '';
  double progressValue = 1;
  String selectedEngine = 'google';
  String currentUrl = '';
  String currentTitle = '';
  Key webKey = UniqueKey();
  bool canGoBack = false;
  bool canGoForward = false;

  void rebuildWeb(){
    searchValue = '';
    txtSearch = TextEditingController();
    webKey = UniqueKey();
    notifyListeners();
  }

  // PROGRESS VALUE UPDATER
  void updateProgressValue(int value) {
    progressValue = value / 100;
    notifyListeners();
  }

  // SEARCH
  void search([String? value]) {
    searchValue = value ?? '';
    webController.loadUrl(
      urlRequest: URLRequest(
        url: WebUri(
          searchValue != '' ? selectedEngine == 'duckduckgo' ? 'https://duckduckgo.com/?va=c&t=ha&q=$searchValue&ia=web' :'https://www.$selectedEngine.com/search?q=$searchValue' : 'https://www.$selectedEngine.com/',
        ),
      ),
    );
    notifyListeners();
  }

  void fetchWebData() async {
    log('Called Fetch Data..............................');
    WebUri? webUri = await webController.getUrl();
    if (webUri != null) {
      currentUrl = webUri.toString(); // or webUri.url if there's such a method/property
    } else {
      log('URL is null');
    }
    currentTitle = await webController.getTitle() as String;
    log('Url: $currentUrl\n Title: $currentTitle');
  }

  setSearchEngine({required BuildContext context, required String value}) {
    selectedEngine = value;
    log(selectedEngine);
    notifyListeners();
  }

  void updateState() async {
    canGoBack = await webController.canGoBack();
    canGoForward = await webController.canGoForward();
    fetchWebData();
    notifyListeners();
  }

  void goBack(){
    webController.goBack();
  }

  void goForward(){
    webController.goForward();
  }

  void reload(){
    webController.reload();
  }

  void goHome(){
    rebuildWeb();
  }
}
