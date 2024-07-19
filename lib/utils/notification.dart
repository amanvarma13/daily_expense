import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../modules/reminder_notification_screen/reminder_model/reminder.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> init() async {
    final androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iosSettings = IOSInitializationSettings();
    final settings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    await flutterLocalNotificationsPlugin.initialize(settings);
  }

  Future<void> scheduleNotification(Reminder reminder) async {
    final androidDetails = AndroidNotificationDetails(
      'reminder_channel',
      'Reminders''Channel for reminder notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    final iosDetails = IOSNotificationDetails();
    final details = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await flutterLocalNotificationsPlugin.schedule(
      reminder.id!,
      reminder.title,
      reminder.description,
      reminder.dateTime,
      details,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> showNotification(String title, String body, DateTime scheduledDateTime) async {
    try {
      final tz.TZDateTime scheduledDateTimeTZ = tz.TZDateTime.from(scheduledDateTime, tz.local);

      const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        channelDescription: 'your_channel_description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );

      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        scheduledDateTimeTZ,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
        uiLocalNotificationDateInterpretation:  UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      print("Error showing notification: $e");
    }
  }
}

