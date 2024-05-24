import 'package:flutter/material.dart';

class OfflineContent extends StatelessWidget {
  const OfflineContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}