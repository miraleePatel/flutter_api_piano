// ignore_for_file: unused_import, await_only_futures, prefer_const_constructors, prefer_typing_uninitialized_variables, non_constant_identifier_names, unnecessary_import, avoid_print, unnecessary_brace_in_string_interps
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:piano_project/Routes/app_pages.dart';
import 'package:sizer/sizer.dart';
import 'Routes/routes.dart';
import 'Screen/Authetication/otp_screen.dart';
import 'Utils/app_color.dart';
import 'Utils/constant_widgets.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
/* Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kDebugMode) {
    print('||||||||||||||||||||=> [Background Notification] <=||||||||||||||||||||');
  }
  Platform.isAndroid ? showNotificationAndroid(message) : showNotificationIos(message);
} */

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  if (message.data.containsKey('notificationId')) {
    // Extract the unique identifier from the payload
    int? notificationId = int.tryParse(message.data['notificationId'] ?? '');
    if (notificationId != null) {
      // Process the payload based on the unique identifier
      switch (notificationId) {
        case 1:
          // Show a specific notification for notification with ID 1
          Platform.isAndroid ? showNotificationAndroid(message) : showNotificationIos(message);
          break;
        case 2:
          // Show a specific notification for notification with ID 2
          // Add more cases as needed for different notification IDs
          Platform.isAndroid ? showNotificationAndroid(message) : showNotificationIos(message);
          break;
        // Add more cases as needed for different notification IDs
        default:
          // Handle other notification IDs or unknown IDs
          break;
      }
    }
  }
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

showNotificationIos(RemoteMessage message) {
  if (message.data.isNotEmpty) {
    if (kDebugMode) {
      print("[Notification] -> ${message.data}");
    }
    var payload = message.data['type'];
    if (message.data['title'] != null && message.data['body'] != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        message.hashCode,
        message.data['title'],
        message.data['body'],
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel_id',
            'channel_name',
            channelDescription: 'channel_description',
            priority: Priority.high,
            importance: Importance.high,
            playSound: true,
            enableLights: true,
            enableVibration: true,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: IOSNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: payload,
      );
    }
  }
}

showNotificationAndroid(RemoteMessage message) {
  if (kDebugMode) {
    print("[Notification] -> ${message.notification!.title}");
  }
  if (kDebugMode) {
    print("[Notification] -> ${message.notification!.body}");
    print("[Notification] -> ${message.data['type']}");
  }
  var payload = message.data['type'];
  if (message.notification!.title != null && message.notification!.body != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification!.title,
      message.notification!.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          channelDescription: 'channel_description',
          priority: Priority.high,
          importance: Importance.high,
          playSound: true,
          enableLights: true,
          enableVibration: true,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: IOSNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: payload,
    );
  }
}

Future<void> main() async {
  stutesbar();
  await WidgetsFlutterBinding.ensureInitialized();
  GetStorage.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  /* await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
    defaultPresentBadge: true,
    defaultPresentSound: true,
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: onSelectNotification);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
 */

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    notificationHandler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Piano App',
          // theme: ThemeData.light(),
          theme: ThemeData(
            primarySwatch: primaryColorSwatch,
          ),
          getPages: AppPages.routes,
          initialRoute: AppPages.INITIAL_ROUTE,
          // home: ApplePayScreen(),
          builder: EasyLoading.init(),
        );
      },
    );
  }

  notificationHandler() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      defaultPresentBadge: true,
      defaultPresentSound: true,
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    Future<void> onSelectNotification(String? payload) async {
      print("PAYLOAD:::${payload}");
      if (payload == "createEvent") {
        Get.toNamed(Routes.EVENT_CONSERT_SCREEN);
      } else if (payload == "eventInfo") {
        Get.toNamed(Routes.EVENT_BOOK_USER_DETAILS_SCREEN);
      } else if (payload == "studioAlert") {
        Get.toNamed(Routes.STUDIO_RENTALS_SCREEN);
      } else {
        Get.toNamed(Routes.DASHBOARD_SCREEN);
      }
    }

    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    firebaseMessaging.setAutoInitEnabled(true);

    firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    firebaseMessaging.requestPermission(
      alert: true,
      sound: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
    );

    var notification_type;

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        Platform.isAndroid ? showNotificationAndroid(message) : showNotificationIos(message);
        var data = await FirebaseMessaging.instance.getToken();
        notification_type = message.data;
        if (kDebugMode) {
          print(
              "notification :::::::::::::::::::::::::::::::: data -> $notification_type category -> ${message.category} messageType -> ${message.messageType} notification -> ${message.notification} ttl -> ${message.ttl}");
        }
        if (kDebugMode) {
          print("FCM Token ::::::::::::::::::::::::::::::::$data");
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle the case when the app is in the background and the user taps on the notification
      var payload = message.data['type'];
      if (payload == "createEvent") {
        Get.toNamed(Routes.EVENT_CONSERT_SCREEN);
      } else if (payload == "eventInfo") {
        Get.toNamed(Routes.EVENT_BOOK_USER_DETAILS_SCREEN);
      } else if (payload == "studioAlert") {
        Get.toNamed(Routes.STUDIO_RENTALS_SCREEN);
      } else {
        Get.toNamed(Routes.DASHBOARD_SCREEN);
      }
    });
  }
}

/* import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:piano_project/Routes/app_pages.dart';
import 'package:sizer/sizer.dart';
import 'Routes/routes.dart';
import 'Screen/Authetication/otp_screen.dart';
import 'Utils/app_color.dart';
import 'Utils/constant_widgets.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kDebugMode) {
    print('||||||||||||||||||||=> [Background Notification] <=||||||||||||||||||||');
  }
  Platform.isAndroid ? showNotificationAndroid(message) : showNotificationIos(message);
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

showNotificationIos(RemoteMessage message) {
  if (message.data.isNotEmpty) {
    if (kDebugMode) {
      print("[Notification] -> ${message.data}");
    }
    if (message.data['title'] != null && message.data['body'] != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        message.hashCode,
        message.data['title'],
        message.data['body'],
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel_id',
            'channel_name',
            channelDescription: 'channel_description',
            priority: Priority.high,
            importance: Importance.high,
            playSound: true,
            enableLights: true,
            enableVibration: true,
            icon: '@mipmap/ic_launcher',
            sound: RawResourceAndroidNotificationSound('incoming'),
          ),
          iOS: IOSNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
      );
    }
  }
}

showNotificationAndroid(RemoteMessage message) {
  if (kDebugMode) {
    print("[Notification] -> ${message.notification!.title}");
    print("[Notification] -> ${message.notification!.body}");
    print("[Notification] -> ${message.data['type']}");
    print("[Notification]->${message.toMap()}");
  }

  if (message.notification!.title != null && message.notification!.body != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification!.title,
      message.notification!.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          channelDescription: 'channel_description',
          priority: Priority.high,
          importance: Importance.high,
          playSound: true,
          enableLights: true,
          enableVibration: true,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: IOSNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }
}

void main() async {
  stutesbar();
  await WidgetsFlutterBinding.ensureInitialized();
  GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    notificationHandler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Piano App',
          theme: ThemeData.light(),
          getPages: AppPages.routes,
          initialRoute: AppPages.INITIAL_ROUTE,
          // home: PaytabsDemo(),
          builder: EasyLoading.init(),
        );
      },
    );
  }

  notificationHandler() async {
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    firebaseMessaging.setAutoInitEnabled(true);

    firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    firebaseMessaging.requestPermission(
      alert: true,
      sound: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
    );
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        Platform.isAndroid ? showNotificationAndroid(message) : showNotificationIos(message);
      },
    );
  }
}
 */