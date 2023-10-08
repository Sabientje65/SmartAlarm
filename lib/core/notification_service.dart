


import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
// import 'dart:async' as DAsync;

class NotificationService {

  /**
    Worth considering: Take in 'priority' in factory, have either an 'alarm notification' and an 'regular' notification service?
   */

  /// Singleton instance of [NotificationService]
  static final NotificationService _instance = NotificationService._internal();

  // Purely for testing purposes, can we display notifications when running in the background?
  // usecase being an android device (emulator)
  // final Workmanager _workManager = Workmanager();

  final FlutterLocalNotificationsPlugin _notificationManager = FlutterLocalNotificationsPlugin();

  /// Private constructor for use in conjunction with factory -> create singleton
  NotificationService._internal();

  var _id = 0;

  /// Obtain an NotificationService instance
  factory NotificationService() => _instance;

  Future<void> startMonitoring() async {
    final Future<bool> done = Future.value(true);

    // _workManager.executeTask((taskName, inputData) => Future.value(true));

    // return await _workManager.registerPeriodicTask(
    //   "notificationservice-monitor",
    //   "notificationservice-monitor",
    //   frequency: const Duration(seconds: 2)
    // );
  }

  Future<void> show( String title, String body ) async {
    await _initialize();

    // _workManager.registerOneOffTask(
    //   "background_notification",
    //   "background_notification",
    //   initialDelay: const Duration(seconds: 2, milliseconds: 500),
    // );

    // _workManager.executeTask((taskName, inputData) => {
    //
    // })

    const AndroidNotificationDetails android = AndroidNotificationDetails(
      "channel_id_1",
      "channel_name",
      importance: Importance.high,
      priority: Priority.high,
      audioAttributesUsage: AudioAttributesUsage.alarm,
      enableLights: true,
      enableVibration: true,
      icon: "@mipmap/ic_launcher"
    );

    // todo: figure out ios notifications
    const DarwinNotificationDetails ios = DarwinNotificationDetails(
      interruptionLevel: InterruptionLevel.timeSensitive
    );

    return await _notificationManager.show(
        ++_id,
        title,
        body,
        const NotificationDetails(
          android: android
        )
    );
  }

  /// Prepare the underlying [FlutterLocalNotificationsPlugin] for fanning out notifications, creating the required channels, etc.
  Future<void> _initialize() async {
    const AndroidInitializationSettings android = AndroidInitializationSettings("@mipmap/ic_launcher");

    await _notificationManager.initialize(const InitializationSettings(android: android));
  }

  bool _canSend() {
    return true;
  }

}
