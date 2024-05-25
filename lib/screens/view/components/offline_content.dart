import 'package:flutter/material.dart';

class OfflineContent extends StatelessWidget {
  const OfflineContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('assets/offline.jpg', fit: BoxFit.contain,),
    );
  }
}