//this is the name given to the background fetch
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

const simplePeriodicTask = "simplePeriodicTask";
// flutter local notification setup
void showNotification(msg, flp) async {
  var android = AndroidNotificationDetails(
      'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
      priority: Priority.high, importance: Importance.max);
  var iOS = IOSNotificationDetails();
  var platform = NotificationDetails(android: android, iOS: iOS);
  await flp.show(0, 'Virtual intelligent solution', '$msg', platform,
      payload: 'VIS \n $msg');
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
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
  var convert = json.decode(response.body);
  if (convert['status'] == true) {
    showNotification(convert['msg'], flp);
  } else {
    print("no message");
  }
}
