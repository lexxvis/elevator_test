import 'package:elevator_test/utils/constants/colors.dart';
import 'package:elevator_test/utils/constants/strings.dart';
import 'package:flutter/material.dart';

import '../../config/routers/app_routers.dart';

///
/// House element widget in list
/// [height],[width] - set size for responsive layout
/// [element] - description house element
///
class HouseItem extends StatelessWidget {
  final (String, int) element;
  final double height;
  final double width;

  const HouseItem(
      {required this.element, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      /// press to the list element, move to the next page
      /// pass the parameters
      onTap: () => router.pushNamed('floors', pathParameters: {
        'name': element.$1,
        'floorsCounter': element.$2.toString()
      }),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(height: height / 3),
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: AppColors.mainScreenBackground,
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    flex: 1,
                    child: Center(child: Text(AppStrings.house)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(child: Text(element.$1)),
                  ),
                ],
              ),
            ),
            SizedBox(height: height / 3),
          ],
        ),
      ),
    );
  }
}
