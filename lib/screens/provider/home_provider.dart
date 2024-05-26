import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../model/browser_model.dart';

class HomeProvider extends ChangeNotifier {
  double progressValue = 1;
  late InAppWebViewController webController;
  late PullToRefreshController pullToRefreshController;
  TextEditingController txtSearch = TextEditingController();
  String? searchKey;
  String searchEngineName = 'google';
  bool canGoBackToHome = false;
  bool canGoBack = false;
  bool canGoForward = false;

  // CONSTRUCTOR
  HomeProvider(){
    pullToRefreshController = PullToRefreshController(
      onRefresh: (){
        webController.reload();
      }
    );
  }

  Future<void> endRefreshing() async {
    await pullToRefreshController.endRefreshing();
    notifyListeners();
  }

  List<String> searchEngineList = [
    'https://www.google.com/',
    'https://in.search.yahoo.com/?fr2=inr',
    'https://www.bing.com/',
    'https://duckduckgo.com/',
  ];

  // HISTORY AND BOOKMARK LIST
  bool isExistingToBookmark = false;
  List<BrowserModel> historyList = [];
  List<BrowserModel> bookmarkList = [];

  // TITLE AND URL
  String currentTitle = '';
  String currentUrl = '';


  // CHECK IF ALREADY EXISTS IN BOOKMARK
  void checkIfExistInBookMark() {
    bool isFound = false;
    log('------------------------------ Checking bookmark ------------------------------');
    for (int i = 0; i < bookmarkList.length; i++) {
      if (currentUrl == bookmarkList[i].url) {
        isFound = true;
        break;
      }
    }
    isExistingToBookmark = isFound;
    notifyListeners();
  }

  // ADD TO BOOKMARK LIST
  void addToBookmark(){
    bookmarkList.add(BrowserModel(
        title: currentTitle, url: currentUrl, time: DateTime.now()));
    log('------------------------------ Added to bookmark ------------------------------');
    checkIfExistInBookMark();
  }

  // UPDATE PROGRESS VALUE
  void updateProgressValue(int progress) {
    progressValue = progress / 100;
    notifyListeners();
  }

  // SET CONTROLLER
  void setWebController(InAppWebViewController controller) {
    log('------------------------------ setting up controller ------------------------------');
    webController = controller;
    notifyListeners();
  }


  // LOAD BOOKMARK AND HISTORY
  void loadBookmarkAndHistory(String url){
    webController.loadUrl(
      urlRequest: URLRequest(
        url: WebUri(url),
      ),
    );
  }


  // LOAD SEARCH URL
  void loadSearchKey() {
    searchKey = txtSearch.text;
    String searchUrl = '';
    log('------------------------------ loading search key ------------------------------');
    if (searchEngineName == 'google') {
      searchUrl = 'https://www.google.com/search?q=$searchKey&sca_esv=cfae4c7047bddcaf&sxsrf=ADLYWIJLZmlaBjjXUxmkcPHZeE-YTOK3Yw%3A1716656190060&source=hp&ei=PhhSZodh4Yrj4Q_akaCYAg&iflsig=AL9hbdgAAAAAZlImTlw4iGj38z94GZ7J2qgzO_oruNjD&ved=0ahUKEwiH-KDToqmGAxVhxTgGHdoICCMQ4dUDCBY&uact=5&oq=flutter&gs_lp=Egdnd3Mtd2l6IgdmbHV0dGVyMgQQIxgnMgoQIxiABBgnGIoFMgoQIxiABBgnGIoFMgoQABiABBhDGIoFMgoQABiABBhDGIoFMgoQABiABBhDGIoFMg0QABiABBixAxhDGIoFMgoQABiABBhDGIoFMg0QABiABBixAxhDGIoFMggQABiABBixA0ixDVCTBFjPC3ABeACQAQGYAbYCoAHoCaoBBzAuNi4wLjG4AQPIAQD4AQGYAgegAtEHqAIKwgIHECMYJxjqAsICERAuGIAEGLEDGNEDGIMBGMcBwgILEAAYgAQYsQMYgwHCAg4QLhiABBixAxiDARiKBcICFhAuGIAEGLEDGNEDGEMYgwEYxwEYigXCAgoQLhiABBhDGIoFwgIQEAAYgAQYsQMYQxiDARiKBZgDC5IHAzEuNqAHuEg&sclient=gws-wiz';
    } else if (searchEngineName == 'yahoo'){
      searchUrl = 'https://in.search.yahoo.com/search;_ylt=Awr1QOVS2FJmisM46fC6HAx.;_ylc=X1MDMjExNDcyMzAwMgRfcgMyBGZyAwRmcjIDcDpzLHY6c2ZwLG06c2EtZ3Atc2VhcmNoBGdwcmlkAzluNnZuaUU0UXp1dEtYM0dVT09YbkEEbl9yc2x0AzAEbl9zdWdnAzkEb3JpZ2luA2luLnNlYXJjaC55YWhvby5jb20EcG9zAzMEcHFzdHIDZmx1dHRlcgRwcXN0cmwDNwRxc3RybAMxMQRxdWVyeQNmbHV0dGVyJTIwc2RrBHRfc3RtcAMxNzE2NzA1Mzk4BHVzZV9jYXNlAw--?p=$searchKey&fr=sfp&fr2=p%3As%2Cv%3Asfp%2Cm%3Asa-gp-search&iscqry=';
    } else if (searchEngineName == 'bing'){
      searchUrl = 'https://www.bing.com/search?q=$searchKey&form=QBLH&sp=-1&lq=0&pq=appl&sc=11-4&qs=n&sk=&cvid=C2BD1AA238B148B7BD9CA9110E0BCE97&ghsh=0&ghacc=0&ghpl=';
    } else if (searchEngineName == 'duckduckgo'){
      searchUrl = 'https://duckduckgo.com/?va=c&t=hl&q=$searchKey&ia=web';
    }
    webController.loadUrl(
      urlRequest: URLRequest(
        url: WebUri(searchUrl),
      ),
    );
  }

  // GET AND PRINT CURRENT URL AND TITLE
  Future<void> getTitleAndUrl() async {
    currentTitle = await webController.getTitle() as String;
    WebUri? webUri = await webController.getUrl();
    currentUrl = webUri.toString();

    log('------------------------------ Fetched title and url ------------------------------');
    log('------------------------------ Title: $currentTitle ------------------------------');
    log('------------------------------ Url: $currentUrl ------------------------------');

    notifyListeners();
  }

  // ADD WEB DATA TO HISTORY LIST
  void addToHistoryList() {
    historyList.add(BrowserModel(
        title: currentTitle, url: currentUrl, time: DateTime.now()));
    log('------------------------------ Added to history ------------------------------');
    notifyListeners();
  }

  // LOAD SEARCH ENGINE
  void loadSearchEngine(String name) {
    searchKey = '';
    txtSearch.clear();
    searchEngineName = name;
    String searchEngineUrl = '';
    if (searchEngineName == 'google') {
      searchEngineUrl = 'https://www.google.com/';
    } else if (searchEngineName == 'yahoo') {
      searchEngineUrl = 'https://in.search.yahoo.com/?fr2=inr';
    } else if (searchEngineName == 'bing') {
      searchEngineUrl = 'https://www.bing.com/';
    } else {
      searchEngineUrl = 'https://duckduckgo.com/';
    }
    log('------------------------------ Loading Search Engine ------------------------------');
    webController
        .loadUrl(
          urlRequest: URLRequest(
            url: WebUri(searchEngineUrl),
          ),
        )
        .then((value) => canGoBackToHome = false);
  }

  // BACK TO PREVIOUS PAGE
  Future<void> goBack() async {
    log('------------------------------ Going Back ------------------------------');
    await webController.goBack();
  }


  // BACK TO FORWARD PAGE
  Future<void> goForward() async {
    await webController.goForward();
    log('------------------------------ Going Forward ------------------------------');
  }

  // JUMP TO HOME PAGE
  void goToHomePage(){
    log('------------------------------ Going To Home Page($searchEngineName) ------------------------------');
    loadSearchEngine(searchEngineName);
  }

  // RELOAD WEBSITE
  Future<void> reload() async {
    await webController.reload();
    log('------------------------------ Reloading ------------------------------');
  }

  // CHECK IF CAN GO BACK , FORWARD , OR HOME
  Future<void> checkCanGoBackForwardHome() async {
    if (searchEngineList.contains(currentUrl)) {
      canGoBack = false;
      canGoBackToHome = false;
    } else {
      canGoBack = await webController.canGoBack();
      canGoForward = await webController.canGoForward();
      if (canGoBack || canGoForward) {
        canGoBackToHome = true;
      }
    }
    notifyListeners();
    log('------------------------------ Back: $canGoBack ------------------------------');
    log('------------------------------ Forward: $canGoForward ------------------------------');
    log('------------------------------ Home: $canGoBackToHome ------------------------------');
    log('------------------------------ Checked Navigation allowed or not ------------------------------');
  }
}
