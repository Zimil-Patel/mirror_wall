import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../model/browser_model.dart';

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
  List<BrowserModel> bookMarkList = [];
  List<BrowserModel> historyList = [];
  bool isContainsInBookmark = false;

  void rebuildWeb() {
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
  void search(String value) {
    if (value.isNotEmpty && value != searchValue) {
      searchValue = value;
      webController.loadUrl(
        urlRequest: URLRequest(
          url: WebUri('https://www.$selectedEngine.com/search?q=$searchValue'),
        ),
      );
      notifyListeners();
    }
  }

  void addToHistory() {
    log('Added to history');
    if (currentUrl != 'https://www.$selectedEngine.com/') {
      historyList.add(BrowserModel(title: currentTitle, url: currentUrl, time: DateTime.now()));
    }
  }

  void addToBookMarks() {
    bookMarkList.add(BrowserModel(title: currentTitle, url: currentUrl, time: DateTime.now()));
    isContainsInBookmark = checkIfExistInBookMark();
    notifyListeners();
  }

  void fetchWebData() async {
    log('Called Fetch Data..............................');
    WebUri? webUri = await webController.getUrl();
    if (webUri != null) {
      currentUrl = webUri.toString();
    } else {
      log('URL is null');
    }
    currentTitle = await webController.getTitle() as String;
    log('Url: $currentUrl\n Title: $currentTitle');
    isContainsInBookmark = checkIfExistInBookMark();
    addToHistory();
  }

  setSearchEngine({required BuildContext context, required String value}) {
    selectedEngine = value;
    rebuildWeb();
    log(selectedEngine);
    notifyListeners();
  }

  void updateState() async {
    canGoBack = await webController.canGoBack();
    canGoForward = await webController.canGoForward();
    fetchWebData();
    notifyListeners();
  }

  void goBack() {
    webController.goBack();
  }

  void goForward() {
    webController.goForward();
  }

  void reload() {
    webController.reload();
  }

  void goHome() {
    txtSearch.clear();
    rebuildWeb();
  }

  bool checkIfExistInBookMark() {
    log('Called Check if exists');
    for (int i = 0; i < bookMarkList.length; i++) {
      if (currentUrl == bookMarkList[i].url) {
        return true;
      }
    }
    return false;
  }

  void loadHistoryOrBookmark(String url) {
    webController.loadUrl(
      urlRequest: URLRequest(
        url: WebUri(url),
      ),
    );
    webController.clearHistory();
    updateState();
    notifyListeners();
  }
}
