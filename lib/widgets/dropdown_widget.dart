import 'package:flutter/material.dart';

class DropDownsWidget extends StatelessWidget {
  final List<String> itemList;

  final double iconWidth;
  final double iconHeight;
  final double horizontalPadding;
  final TextEditingController controller;
  final void Function(String?) onChanged;

  const DropDownsWidget({
    super.key,
    required this.itemList,
    this.iconWidth = 24,
    this.iconHeight = 24,
    this.horizontalPadding = 14.0,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: DropdownButton(
        icon: const Icon(
          Icons.arrow_drop_down,
          size: 16, color: Colors.black
        ),
        menuMaxHeight: 300,
        underline: const SizedBox(),
        alignment: Alignment.center,
        items: itemList.map<DropdownMenuItem<String>>((String item) {
          return DropdownMenuItem(
            alignment: Alignment.center,
            enabled: true,
            value: item,
            child: Center(child: Text(item)),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}

