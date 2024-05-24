import 'package:flutter/material.dart';
import 'package:mirror_wall/screens/provider/home_provider.dart';
import 'package:mirror_wall/screens/view/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => HomeProvider(),
    )
  ], child: const MirrorWall()));
}

class MirrorWall extends StatelessWidget {
  const MirrorWall({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
