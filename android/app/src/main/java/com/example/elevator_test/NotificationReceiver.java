package com.example.elevator_test;

import android.app.Activity;
import android.app.AlarmManager;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.BitmapFactory;
import android.os.Build;

import androidx.core.app.NotificationCompat;

import java.util.Calendar;

/// utilizes the background notification logic class
/// notifications invokes every 1 minutes and show last active current elevator floor
/// show Flutter bird icon and message and vibration
/// save in shared preferences current floor state
public class NotificationReceiver extends BroadcastReceiver {

    /// integer constant used to identify the service
    public static final int SERVICE_ID = 0x11;

    /// share preferences key
    private static final String PREF_KEY = "floorKey";

    @Override
    public void onReceive(Context ctx, Intent intent) {
        NotificationManager notificationManager =
                (NotificationManager) ctx.getSystemService(Context.NOTIFICATION_SERVICE);

        String NOTIFICATION_CHANNEL_ID = "elevator_id_01";

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel notificationChannel = new
                    NotificationChannel(NOTIFICATION_CHANNEL_ID, "elevator notification",
                    NotificationManager.IMPORTANCE_DEFAULT);
            // Configure the notification channel.
            notificationChannel.setDescription("Channel description");
            notificationChannel.enableLights(true);
            notificationChannel.setVibrationPattern(new long[]{0, 500, 200, 500, 200});
            notificationChannel.enableVibration(true);
            notificationManager.createNotificationChannel(notificationChannel);
        }


        NotificationCompat.Builder notificationBuilder =
                new NotificationCompat.Builder(ctx, NOTIFICATION_CHANNEL_ID);

        SharedPreferences sSharedPreferences = ctx.getSharedPreferences(ctx.getPackageName(),
                Activity.MODE_PRIVATE);

        int floor = sSharedPreferences.getInt(PREF_KEY, 0);

        notificationBuilder.setAutoCancel(true)
                .setDefaults(Notification.DEFAULT_ALL)
                .setWhen(System.currentTimeMillis())
                .setSmallIcon(R.drawable.ic_launcher_round)
                .setLargeIcon(BitmapFactory.decodeResource(ctx.getResources(),
                        R.drawable.ic_launcher_round))
                .setContentTitle("current floor is : " + floor);


        Intent notificationIntent = new Intent(ctx, MainActivity.class);

        PendingIntent contentIntent = PendingIntent.getActivity(ctx,
                0, notificationIntent,
                PendingIntent.FLAG_CANCEL_CURRENT | PendingIntent.FLAG_IMMUTABLE);

        notificationBuilder.setContentIntent(contentIntent);

        notificationManager.notify(1, notificationBuilder.build());
        setNotification(ctx, floor);
    }


    public static void updateCurrentFloor(Context ctx, int floor) {
        SharedPreferences sSharedPreferences = ctx.getSharedPreferences(ctx.getPackageName(),
                Activity.MODE_PRIVATE);
        sSharedPreferences.edit().putInt(PREF_KEY, floor).apply();
    }

    public static void setNotification(Context ctx, int floor) {

        updateCurrentFloor(ctx, floor);

        Intent intent = new Intent(ctx, NotificationReceiver.class);
        PendingIntent pendingIntent = PendingIntent.getBroadcast(
                ctx,
                NotificationReceiver.SERVICE_ID,
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);
        AlarmManager alarmManager = (AlarmManager) ctx.getSystemService(Context.ALARM_SERVICE);

        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(System.currentTimeMillis());
        //calendar.add(Calendar.MINUTE, 1);
        calendar.add(Calendar.SECOND, 20);
        long time = calendar.getTimeInMillis();

        alarmManager.set(AlarmManager.RTC, time, pendingIntent);

    }


    public static void clearNotification(Context ctx) {

        AlarmManager am = (AlarmManager) ctx.getSystemService(Context.ALARM_SERVICE);
        Intent cancelServiceIntent = new Intent(ctx, NotificationReceiver.class);
        PendingIntent cancelServicePendingIntent = PendingIntent.getBroadcast(
                ctx,
                NotificationReceiver.SERVICE_ID,
                cancelServiceIntent, PendingIntent.FLAG_IMMUTABLE
        );
        am.cancel(cancelServicePendingIntent);


        NotificationManager notificationManager =
                (NotificationManager) ctx.getSystemService(Context.NOTIFICATION_SERVICE);
        notificationManager.cancelAll();
    }
}




