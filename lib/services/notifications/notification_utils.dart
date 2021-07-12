//this is the name given to the background fetch
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

const simplePeriodicTask = "simplePeriodicTask";
// flutter local notification setup
void showNotification(msg, flp) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id', 'channel_name', 'channel_description',
      importance: Importance.max, priority: Priority.high);
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flp.show(
    0,
    'title',
    '$msg',
    platformChannelSpecifics,
    payload: 'Default_Sound',
  );
}

Future _showNotificationWithDefaultSound(String title, String message , flp) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id', 'channel_name', 'channel_description',
      importance: Importance.max, priority: Priority.high);
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flp.show(
    0,
    '$title',
    '$message',
    platformChannelSpecifics,
    payload: 'Default_Sound',
  );
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    // var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var android = AndroidInitializationSettings('app_icon');
    var iOS = IOSInitializationSettings();
    var initialSettings = InitializationSettings(android: android, iOS: iOS);
    flp.initialize(initialSettings);

    fetchNotificationFromAPI(flp);

    return Future.value(true);
  });
}

fetchNotificationFromAPI(FlutterLocalNotificationsPlugin flp) async {
  var response =
      await http.post("https://seeviswork.000webhostapp.com/api/testapi.php");
  print("here================");
  print(response);
  var converted = json.decode(response.body);
  if (converted['status'] == true) {
    showNotification(converted['msg'], flp);
  } else {
    print("no message");
  }
}
