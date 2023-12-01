import 'package:pigeon/pigeon.dart';
//dart run pigeon --input pigeons/messaging.dart --dart_out lib/pigeon.dart --objc_header_out ios/Runner/pigeon.h --objc_source_out ios/Runner/pigeon.m --java_out ./android/app/src/main/java/pigeon/Pigeon.java --java_package "com.example.elevator_test"

@HostApi()
abstract class PigeonApi {
    void startNotification();
    void clearNotifications();
    void updateCurrentFloor(int currentFloor);
}