import 'package:flutter/material.dart';

import '../../provider/home_provider.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.providerTrue,
  });

  final HomeProvider providerTrue;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: LinearProgressIndicator(
        value: providerTrue.progressValue,
        minHeight: 2,
        color: Colors.blueAccent,
      ),
    );
  }
}