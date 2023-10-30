
import 'package:flutter/material.dart';
import 'package:ws1/home.dart';
import 'package:ws1/safe.dart';
import 'package:ws1/signin/login.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workmanager/workmanager.dart';

// class LocalNotification {
//   static FlutterLocalNotificationsPlugin flutterNotificationPlugin;
//   static AndroidNotificationDetails androidSettings;
//
//   static Initializer() {
//     flutterNotificationPlugin = FlutterLocalNotificationsPlugin();
//     androidSettings = AndroidNotificationDetails(
//         "111", "Background_task_Channel", "Channel to test background task",
//         importance: Importance.High, priority: Priority.Max);
//     var androidInitialization = AndroidInitializationSettings('app_icon');
//     var initializationSettings =
//     InitializationSettings(androidInitialization, null);
//     flutterNotificationPlugin.initialize(initializationSettings,
//         onSelectNotification: onNotificationSelect);
//   }
//
//   static Future<void> onNotificationSelect(String payload) async {
//     print(payload);
//   }
//
//   static ShowOneTimeNotification(DateTime scheduledDate) async {
//     var notificationDetails = NotificationDetails(androidSettings, null);
//     await flutterNotificationPlugin.schedule(1, "Background Task notification",
//         "Data saved to database", scheduledDate, notificationDetails,
//         androidAllowWhileIdle: true);
//   }
// }
//
//
//
// void callbackDispatcher() {
//   Workmanager.executeTask((taskName, inputData) async {
//     //show the notification
//     await Firebase.initializeApp();
//     switch(taskName){
//       case "1": print('task');
//     }
//     LocalNotification.Initializer();
//     LocalNotification.ShowOneTimeNotification(DateTime.now());
//     return Future.value(true);
//   });
// }



// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Workmanager.initialize(callbackDispatcher);
//   await Workmanager.registerPeriodicTask("test_workertask", "test_workertask",
//       inputData: {"data1": "value1", "data2": "value2"},
//       frequency: Duration(minutes: 1),
//       initialDelay: Duration(minutes: 1));
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
