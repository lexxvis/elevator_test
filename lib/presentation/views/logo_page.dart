import 'package:elevator_test/config/routers/app_routers.dart';
import 'package:elevator_test/utils/constants/colors.dart';
import 'package:elevator_test/utils/constants/dimentions.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/strings.dart';

class LogoPage extends StatelessWidget {
  const LogoPage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime lastExitTime = DateTime.now();
    return SafeArea(

        /// deprecated ? change to PopScope
        child: WillPopScope(

            /// check press back button if press twice in 2 seconds then exit
            onWillPop: () async {
              if (DateTime.now().difference(lastExitTime) >=
                  const Duration(seconds: 2)) {
                var snack = const SnackBar(
                  backgroundColor: Colors.blueGrey,
                  content: Text(AppStrings.exitConfirmation),
                  duration: Duration(seconds: 2),
                );
                ScaffoldMessenger.of(context).showSnackBar(snack);
                lastExitTime = DateTime.now();
                return false;
              } else {
                /// exit
                return true;
              }
            },
            child: Scaffold(
                body: Container(
              color: AppColors.mainScreenBackground,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double kHeight = constraints.maxHeight / layoutHeight;
                  double kWidth = constraints.maxWidth / layoutWidth;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 154 * kHeight,
                        child: const Text(
                          AppStrings.logoText,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      Positioned(
                        height: logoHeight * kHeight,
                        width: logoHeight * kHeight,
                        top: logoTop * kHeight,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: AppColors.border)),
                          child: Image.asset('assets/images/elevator.jpg'),
                        ),
                      ),
                      Positioned(
                        height: btnHeight * kHeight,
                        width: btnWidth * kHeight, //logoHeight * kHeight,
                        top: btnTop * kHeight, //logoTop * kHeight,
                        child: OutlinedButton(
                          onPressed: () {
                            router.pushNamed('house');
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            side:
                                const BorderSide(color: Colors.black, width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(btnRadius),
                            ),
                          ),
                          child: const Text(
                            AppStrings.btnText,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 753 * kHeight,
                        left: 200 * kWidth,
                        child: const Text(
                          AppStrings.designedBy,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
            )
        )
    );
  }
}
