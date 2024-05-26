import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../provider/home_provider.dart';
import 'bottom_modal_sheet.dart';

class HomePageBottomActionBar extends StatelessWidget {
  const HomePageBottomActionBar({
    super.key,
    required this.providerTrue,
    required this.providerFalse,
  });

  final HomeProvider providerTrue, providerFalse;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.4),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: providerTrue.canGoBack ? () => providerFalse.goBack() : null,
              icon: Icon(
                Icons.arrow_back_rounded,
                size: height * 0.034,
              ),
            ),
            IconButton(
              onPressed: providerTrue.canGoForward ? () => providerFalse.goForward() : null,
              icon: Icon(
                Icons.arrow_forward_rounded,
                size: height * 0.034,
              ),
            ),
            IconButton(
              onPressed: () => providerFalse.reload(),
              icon: Icon(
                Icons.refresh,
                size: height * 0.034,
              ),
            ),
            IconButton(
              onPressed: providerTrue.canGoBackToHome ? () => providerFalse.goToHomePage() : null,
              icon: Icon(
                Icons.home_outlined,
                size: height * 0.034,
              ),
            ),
            IconButton(
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => const BottomModelSheet(),
                );
              },
              icon: Icon(
                Icons.more_horiz_rounded,
                size: height * 0.034,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
