import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import 'icon_with_lable.dart';

class BottomModelSheet extends StatelessWidget {
  const BottomModelSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height / 4.4,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xffecf5ff),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // DROP DOWN BUTTON
          GestureDetector(
            onVerticalDragDown: (details) {
              Navigator.pop(context);
            },
            child: Container(
              height: 6,
              width: 40,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade400,
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          // ACTION BUTTONS ROW
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconWithLable(icon: Icons.star_border_rounded, lable: 'Bookmarks',),
              IconWithLable(icon: Icons.history, lable: 'History',),
              IconWithLable(icon: Icons.change_circle_outlined, lable: 'Change Search\nEngine',),
            ],
          ),
        ],
      ),
    );
  }
}
