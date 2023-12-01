import 'dart:async';

import 'package:elevator_test/presentation/widgets/floor_item.dart';
import 'package:elevator_test/utils/constants/strings.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/dimentions.dart';

class FloorsPage extends StatefulWidget {
  final String? name;
  final int? floorsCounter;

  const FloorsPage({super.key, this.name, this.floorsCounter});

  @override
  State<FloorsPage> createState() => FloorsPageState();
}

class FloorsPageState extends State<FloorsPage> {

  int selectedIndex = 0;
  int currentIndex = 0;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            color: AppColors.mainScreenBackground,
            child: Column(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${AppStrings.floorsTitle} ${widget.name}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            )),
                        const Divider(
                            color: Colors.black,
                            thickness: 1,
                            indent: 25,
                            endIndent: 25)
                      ],
                    )),
                Expanded(
                    flex: 7,
                    child: CustomScrollView(
                      //controller: _controller,
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (_, index) => FloorItem(
                              color: _checkColor(index),
                              index: index,
                              height: MediaQuery.sizeOf(context).height /
                                  layoutHeight * 40,
                              width: MediaQuery.sizeOf(context).height /
                                  layoutHeight * 228,
                            ),
                            childCount: widget.floorsCounter ?? 0,
                          ),
                        ),
                      ],
                    )),
                const Expanded(
                    flex: 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppStrings.designedBy,
                              style: TextStyle(fontSize: 14),
                            )))),
              ],
            )),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// select color according to index
  Color _checkColor(int index) {
    if (index != selectedIndex && index != currentIndex) {
      return AppColors.mainScreenBackground;
    }
    if (index == currentIndex) {
      return AppColors.currentFloor;
    } else {
      return AppColors.selectedFloor;
    }
  }

  @override
  void initState() {
    super.initState();
    /// interact with native, start notifications and set floor count
    pigeonApi.startNotification();
    pigeonApi.updateCurrentFloor(1);
  }

  /// start elevator animation
  void startElevate(int index) {
    if (index != selectedIndex) {
      selectedIndex = index;
      setState(() {});
      _timer?.cancel();
      /// start 3 sec timer
      _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        if (currentIndex == selectedIndex) {
          _timer?.cancel();
          return;
        } else if (currentIndex > selectedIndex) {
          currentIndex--;
        } else {
          currentIndex++;
        }
        /// update native floor index
        pigeonApi.updateCurrentFloor(currentIndex + 1);
        /// check if widget mounted
        if (mounted) setState(() {});
      });
    }
  }
}
