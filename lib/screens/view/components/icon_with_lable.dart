import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirror_wall/screens/view/components/search_engine_dialog.dart';

class IconWithLable extends StatelessWidget {
  const IconWithLable({
    super.key, required this.icon, required this.lable,
  });

  final IconData icon;
  final String lable;


  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        if (lable == 'Change Search\nEngine'){
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const CustomDialog(),
          );
        }
      },
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: Colors.blueAccent,
                size: 35,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              lable,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}