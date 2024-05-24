import 'package:flutter/material.dart';
import 'package:mirror_wall/screens/provider/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});


  @override
  Widget build(BuildContext context) {

    HomeProvider providerFalse = Provider.of<HomeProvider>(context, listen: false);
    HomeProvider providerTrue = Provider.of<HomeProvider>(context, listen: true);

    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(left: 20.0, top: 16, bottom: 16),
                  child: Text(
                    'Change Search Engine',
                    style: TextStyle(
                        color: Colors.black, fontSize: height * 0.025),
                  ),
                ),
              ],
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(
              child: Column(
                children: [
                  RadioListTile<String>(
                    title: const Text('Google'),
                    value: 'google',
                    groupValue: providerFalse.selectedEngine,
                    onChanged: (value) {
                      providerFalse.setSearchEngine(
                          context: context, value: value!);
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Yahoo'),
                    value: 'yahoo',
                    groupValue: providerFalse.selectedEngine,
                    onChanged: (value) {
                      providerFalse.setSearchEngine(
                          context: context, value: value!);
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Bing'),
                    value: 'bing',
                    groupValue: providerFalse.selectedEngine,
                    onChanged: (value) {
                      providerFalse.setSearchEngine(
                          context: context, value: value!);
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Duck Duck Go'),
                    value: 'duckduckgo',
                    groupValue: providerFalse.selectedEngine,
                    onChanged: (value) {
                      providerFalse.setSearchEngine(
                          context: context, value: value!);
                    },
                  ),

                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 0, right: 20),
              child: Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      providerFalse.rebuildWeb();
                      Navigator.pop(context);
                    },
                    child: const Text('Ok',
                        style: TextStyle(color: Colors.blueAccent)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}