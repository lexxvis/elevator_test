package com.example.elevator_test;


import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

public class MainActivity extends FlutterActivity implements com.example.elevator_test.Pigeon.PigeonApi {

    /// indicate if setNotification is already invoked
    boolean isNotificationStarted = false;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        /// init pigeon plugin to establish connection between native and flutter
        com.example.elevator_test.Pigeon.PigeonApi.setUp(flutterEngine.getDartExecutor(), this);
        /// clear notifications if previously it was ran
        NotificationReceiver.clearNotification(this);
    }

    /// configure background notification
    @Override
    public void startNotification() {
        if (!isNotificationStarted) {
            isNotificationStarted = true;
            NotificationReceiver.setNotification(this, 1);
        }
    }

    /// clear current active notifications
    @Override
    public void clearNotifications() {
    }

    /// update current floor index in notifications
    @Override
    public void updateCurrentFloor(@NonNull Long currentFloor) {
        NotificationReceiver.updateCurrentFloor(this, currentFloor.intValue());
    }
}
