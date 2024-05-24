import 'package:flutter/material.dart';
import 'package:mirror_wall/screens/provider/home_provider.dart';

import '../../../utils/constants.dart';


class AppBarActionButtons extends StatelessWidget {
  const AppBarActionButtons({
    super.key,
    required this.providerFalse,
  });

  final HomeProvider providerFalse;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: IconButton(
            onPressed: null,
            icon: Icon(
              Icons.bookmark_add_outlined,
              size: height * 0.034,
            ),
          ),
        ),
        CircleAvatar(
          radius: height * 0.019,
          backgroundImage: const AssetImage('assets/profile.png'),
        )
      ],
    );
  }
}
