import 'package:flutter/material.dart';
import 'package:mirror_wall/screens/provider/home_provider.dart';

class AppBarSearchTextField extends StatelessWidget {
  const AppBarSearchTextField({
    super.key,
    required this.providerFalse,
    required this.providerTrue,
  });

  final HomeProvider providerFalse;
  final HomeProvider providerTrue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 46,
        child: TextField(
          controller: providerTrue.txtSearch,
          onSubmitted: (value) {
            if(value.isNotEmpty && value != ''){
              providerFalse.loadSearchKey();
            }
          },
          textInputAction: TextInputAction.search,
          cursorColor: Colors.black54,
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus!.unfocus(),
          decoration: InputDecoration(
            hintText: 'Search here',
            filled: true,
            fillColor: const Color(0xfff5f5f5),
            contentPadding: const EdgeInsets.only(bottom: 0, left: 0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.05)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.05)),
            ),
          ),
        ),
      ),
    );
  }
}
