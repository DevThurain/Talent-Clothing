import 'package:flutter/material.dart';


class CategoryChip extends StatelessWidget {
  const CategoryChip({
    Key? key,
    required this.title,
    required this.selected,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final bool selected;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(left: 12, top: 9, bottom: 9),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: selected ? Colors.black : Colors.transparent,
            border: Border.all(color: selected ? Colors.black : Colors.black.withOpacity(0.23))),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: selected ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
