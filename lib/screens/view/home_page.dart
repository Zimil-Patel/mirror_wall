import 'package:flutter/material.dart';
import 'package:mirror_wall/screens/provider/home_provider.dart';
import 'package:mirror_wall/screens/view/components/home_page_appbar.dart';
import 'package:mirror_wall/utils/constants.dart';
import 'package:provider/provider.dart';

import 'components/home_page_bottom_action_bar.dart';
import 'components/web_view_box.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    HomeProvider homeProviderTrue =
        Provider.of<HomeProvider>(context, listen: true);
    HomeProvider homeProviderFalse =
        Provider.of<HomeProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      // APP BAR
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: HomePageAppBar(
          providerTrue: homeProviderTrue,
          providerFalse: homeProviderFalse,
        ),
      ),

      // BODY
      body: Column(
        children: [
          // WEB VIEW BOX
          WebViewBox(
              providerTrue: homeProviderTrue, providerFalse: homeProviderFalse),

          // BOTTOM ACTION BAR
          HomePageBottomActionBar(
            providerTrue: homeProviderTrue,
            providerFalse: homeProviderFalse,
          ),
        ],
      ),
    );
  }
}
