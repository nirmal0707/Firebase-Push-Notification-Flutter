import 'package:cloudpushnotification/notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _messaging = FirebaseMessaging();
  List<NotificationModel> _notifications = [];

  _getDeviceToken() {
    _messaging.getToken().then((token) {
      print(token);
    });
  }

  _getNotification() {
    _messaging.configure(
      onMessage: (Map<String, dynamic> notification) async {
        _setNotification(notification);
      },
      onLaunch: (Map<String, dynamic> notification) async {
        _setNotification(notification);
      },
      onResume: (Map<String, dynamic> notification) async {
        _setNotification(notification);
      },
    );
  }

  _setNotification(Map<String, dynamic> notification) async {
    var notificationMap = notification['notification'];
    var dataMap = notification['data'];
    NotificationModel notificationModel = NotificationModel(
      title: notificationMap['title'],
      body: notificationMap['body'],
      message: dataMap['message'],
    );
    setState(() {
      _notifications.add(notificationModel);
    });
  }

  @override
  void initState() {
    super.initState();

    _getDeviceToken();
    _getNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _notifications == null ? 0 : _notifications.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(
                  _notifications[_notifications.length - index - 1].message),
            ),
          );
        },
      ),
    );
  }
}
