import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class HelperNotification {
  // HelperNotification._();
  final http = GetConnect();

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

  sendPushNotification(String? token, String? title, String body) async {
    try {
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
            'android_channel_id': "myservices",
          },
          'to': token
        },
        contentType: 'application/json',
        headers: {
          'Authorization':
              'key=AAAAuO7OiQw:APA91bEmnnGOjk0-lQSm5TkeNhziYgLLpb3oo4-w6OEgRs4E3AD35wgxNSwwdEc1u3_XLXJjgUd_PPtWuWLf074CAkkrUkJpomaoc1Yv__mprKiyvFKZp9vj2Pg0-fxktuYI26O3G3Dv',
        },
      );
    } catch (e) {
      if (kDebugMode) debugPrint('Error push notification $e');
    }
  }
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
