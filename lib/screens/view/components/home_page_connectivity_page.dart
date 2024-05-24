
import 'package:flutter/material.dart';
import 'package:mirror_wall/screens/view/components/web_view_box.dart';
import 'package:provider/provider.dart';

import '../../provider/home_provider.dart';
import 'home_page_appbar.dart';
import 'home_page_bottom_action_bar.dart';

class HomePageConnectivityPage extends StatelessWidget {
  const HomePageConnectivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider providerTrue =
        Provider.of<HomeProvider>(context, listen: true);
    HomeProvider providerFalse =
        Provider.of<HomeProvider>(context, listen: false);

    return Scaffold(
      // APP BAR WITH SEARCH TEXT FIELD
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: HomePageAppBar(
          providerTrue: providerTrue,
          providerFalse: providerFalse,
        ),
      ),

      // BODY OF SCREEN
      body: Column(
        children: [
          // WEB VIEW BOX
          WebViewBox(providerTrue: providerTrue, providerFalse: providerFalse),

          // BOTTOM ACTION BAR
          HomePageBottomActionBar(
            providerTrue: providerTrue,
            providerFalse: providerFalse,
          ),
        ],
      ),
    );
  }
}
