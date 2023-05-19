import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:my_services/constants/firebase_constants.dart';

class HelperNotification {
  // HelperNotification._();
  final http = GetConnect();
  late final String apiKey;

  static Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('');
    } else {
      debugPrint('User declined or not accepted permission');
    }
  }

  void senPushNotification(String? token, String? title, String body) async {
    try {
      await apiCollection.get().then((QuerySnapshot value) {
        for (var doc in value.docs) {
          apiKey = doc['key'];
        }
      });
      if (apiKey.isNotEmpty) {
        await http.post(
          'https://fcm.googleapis.com/fcm/send',
          {
            'priority': 'high',
            'data': {
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'title': title,
              'body': body,
            },
            'notification': {
              'title': title,
              'body': body,
              'android_channel_id': "my_services",
            },
            'to': token
          },
          contentType: 'application/json',
          headers: {
            'Authorization': apiKey,
          },
        );
      }
    } catch (e) {
      if (kDebugMode) debugPrint('Error push notification $e');
    }
  }

  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationsSettings =
        InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onDidReceiveNotificationResponse: (NotificationResponse payload) async {
      try {
        if (payload.payload!.isNotEmpty) {
          debugPrint(payload.payload.toString());
        }
      } catch (e) {
        return;
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      debugPrint(
          "onMessage: ${message.notification!.title}/${message.notification?.body}/${message.notification?.titleLocKey}");
      debugPrint("onMessage message type:${message.data['type']}");
      debugPrint("onMessage message :${message.data}");

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                'my_services',
                'canal_de_notification',
                channelDescription: 'Canal de notificação',
                icon: android.smallIcon,
                importance: Importance.max,
                priority: Priority.high,
                sound:
                    const RawResourceAndroidNotificationSound('notification'),
              ),
            ));
      }
    });
  }
}

Future<dynamic> myBackgroundMessageHandler(message) async {
  debugPrint(
      "onBackground: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
  var androidInitialize =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  // var iOSInitialize = new IOSInitializationSettings();
  var initializationsSettings =
      InitializationSettings(android: androidInitialize);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  // NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, true);
}

showLoading() {
  Get.defaultDialog(
      title: "Loading...",
      content: const CircularProgressIndicator(),
      barrierDismissible: false);
}

dismissLoadingWidget() {
  Get.back();
}

class NotificationController extends GetxController {
  final _notifications = <NotificationModel>[].obs;

  List<NotificationModel> get notifications => _notifications.toList();

  void addNotification(NotificationModel notification) {
    _notifications.add(notification);
  }
}

class NotificationModel {
  final int id;
  final String title;
  final String body;

  NotificationModel(
      {required this.id, required this.title, required this.body});
}
