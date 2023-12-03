import 'package:elevator_test/utils/constants/strings.dart';
import 'package:flutter/material.dart';

import '../views/floors_page.dart';

///
/// floor number list item widget
/// [index] - current item index
/// [color] - item color
/// background color - unselected item
/// yellow color - selected item
/// green color - current item
/// [width], [height] - size for responsive design
///
class FloorItem extends StatelessWidget {
  final int index;
  final double height;
  final double width;
  final Color color;

  const FloorItem(
      {super.key,
      required this.index,
      required this.height,
      required this.width,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      /// find the ancestor of item ( third screen widget )
      /// and start elevate animation
      onTap: () => context
          .findAncestorStateOfType<FloorsPageState>()
          ?.startElevate(index),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Center(child: Text('${AppStrings.floor} ${index + 1}')),
        ),
      ),
    );
  }
}
