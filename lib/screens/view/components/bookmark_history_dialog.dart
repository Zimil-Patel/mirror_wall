import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../model/browser_model.dart';
import '../../provider/home_provider.dart';

class BookmarkHistoryListDialog extends StatelessWidget {
  const BookmarkHistoryListDialog({
    super.key,
    required this.lable,
    required this.homeProviderTrue,
    required this.homeProviderFalse,
  });

  final String lable;
  final HomeProvider homeProviderTrue;
  final HomeProvider homeProviderFalse;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height / 1.09,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xfff0f2f4),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // TEXT BUTTON - DONE
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton(
                  child: const Text(
                    'Done',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),

          // TITLE
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                lable,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),

          // SEARCH FIELD
          Container(
            height: 35,
            width: double.infinity,
            margin:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            padding:
            const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            decoration: BoxDecoration(
              color: const Color(0xffe1e3e5),
              borderRadius: BorderRadiusDirectional.circular(10),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.search_rounded,
                  color: Colors.grey,
                ),
                Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),

          // TITLE
          const SizedBox(
            width: 20,
          ),

          if (lable == 'History')
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10),
              width: width,
              child: const Text(
                'Your Google Account may have other form of browsing history at history.google.com',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
            ),

          if(lable == 'History' && homeProviderTrue.historyList.isNotEmpty) Expanded(
            child: SingleChildScrollView(
              child: Column(
                  children:[ CupertinoListSection.insetGrouped(
                    children: [
                      ...List.generate(homeProviderTrue.historyList.length, (index) =>
                          BrowserDataListTile(data: homeProviderTrue.historyList[index], providerFalse: homeProviderFalse,),),
                    ],
                  ),]
              ),
            ),
          ),

          if(lable == 'Bookmarks' && homeProviderTrue.bookMarkList.isNotEmpty) Expanded(
            child: SingleChildScrollView(
              child: Column(
                  children:[ CupertinoListSection.insetGrouped(
                    children: [
                      ...List.generate(homeProviderTrue.bookMarkList.length, (index) =>
                          BrowserDataListTile(data: homeProviderTrue.bookMarkList[index], providerFalse: homeProviderFalse,),),
                    ],
                  ),]
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BrowserDataListTile extends StatelessWidget {
  const BrowserDataListTile({
    super.key, required this.data, required this.providerFalse,
  });

  final HomeProvider providerFalse;
  final BrowserModel data;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      onTap: () {
        Navigator.pop(context);
        providerFalse.loadHistoryOrBookmark(data.url);
      },
      leading: const CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage('assets/chrome.jpg'),
      ),
      title: Text(data.title),
      subtitle: Text(data.url),
      trailing: Text(
        '${data.time.hour}:${data.time.minute}',
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}