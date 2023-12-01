import 'dart:ui';

import 'package:elevator_test/presentation/widgets/add_house_widget.dart';
import 'package:elevator_test/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_model.dart';
import '../../utils/constants/dimentions.dart';
import '../../utils/constants/strings.dart';
import '../widgets/house_item.dart';

class HousePage extends StatelessWidget {
  const HousePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: AppColors.mainScreenBackground,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                delegate: _MySliverAppBar(expandedHeight: 150),
                pinned: true,
              ),
              /// provider consumer, rebuild if added item received
              Consumer<AppModel>(builder: (context, value, _) {
                return SliverList.builder(
                  itemBuilder: (_, i) => HouseItem(
                    element: value.fetchElement(i),
                    height:
                        MediaQuery.sizeOf(context).height / layoutHeight * 40,
                    width:
                        MediaQuery.sizeOf(context).height / layoutHeight * 228,
                  ),
                  itemCount: value.length,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
/// SLiver App Bar with "Add house" button
class _MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  _MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Container(
          color: AppColors.mainScreenBackground,
        ),
        Positioned(
          width: MediaQuery.sizeOf(context).height / layoutHeight * 228,
          height: MediaQuery.sizeOf(context).height / layoutHeight * 40,
          child: OutlinedButton(
            onPressed: () => showDialog<String>(
              context: context,
              barrierColor: Colors.transparent,
              builder: (BuildContext context) => BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: const Dialog(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  child: AddHouseWidget(),
                ),
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.zero,
              side: const BorderSide(color: Colors.black, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(btnRadius),
              ),
            ),
            child: const Row(children: [
              Expanded(
                flex: 5,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppStrings.addHouse,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Icon(Icons.add, color: Colors.black, size: 35),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
