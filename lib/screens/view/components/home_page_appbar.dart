
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../provider/home_provider.dart';
import 'app_bar_actions.dart';
import 'app_bar_search_field.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({
    super.key,
    required this.providerTrue,
    required this.providerFalse,
  });

  final HomeProvider providerTrue, providerFalse;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      shadowColor: Colors.black.withOpacity(0.4),
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      title: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xfff5f5f5),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [

                  // SEARCH
                  IconButton(
                    onPressed: () {
                      providerFalse.search(providerFalse.txtSearch.text);
                    },
                    icon: Icon(
                      Icons.search_rounded,
                      size: height * 0.032,
                    ),
                  ),

                  // SEARCH TEXT FIELD
                  AppBarSearchTextField(
                      providerFalse: providerFalse, providerTrue: providerTrue),
                ],
              ),
            ),
          ),

          // STAR, DOWNLOAD
          AppBarActionButtons(providerFalse: providerFalse, providerTrue: providerTrue,),
        ],
      ),

    );
  }
}
