import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
///
///  animation between app screens
///   uses in router
///
class TransitionAnimation extends CustomTransitionPage<void> {
  TransitionAnimation({super.key, required super.child})
      : super(
    transitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (_, animation, __, child) {
      return SlideTransition(
        position: animation.drive(
          Tween(
            begin: const Offset(1.5, 0),
            end: Offset.zero,
          ).chain(
            CurveTween(curve: Curves.ease),
          ),
        ),
        child: child,
      );
    },
  );
}
