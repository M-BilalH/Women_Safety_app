import 'dart:async';
import 'dart:ui';

import 'package:another_telephony/telephony.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shake/shake.dart';
import 'package:vibration/vibration.dart';
import 'package:wsfty_apk/db/db_services.dart';
import 'package:wsfty_apk/model/contact_model.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    "Binte Hawwa",
    "Foreground service",
    importance: Importance.high,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);
  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
      notificationChannelId: "Binte Hawwa",
      initialNotificationTitle: "Foreground service",
      initialNotificationContent: "Initializing",
      foregroundServiceNotificationId: 818,
    ),
  );
  service.startService();
}

@pragma("vm:entry-point")
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
        print("✅ onStart executed");
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  Timer.periodic(Duration(seconds: 2), (timer) async {
    if (service is AndroidServiceInstance) {
      if(await service.isForegroundService()){
        await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
    forceAndroidLocationManager: true,
  ).then((Position position){
   _currentPosition=position;
   
  print('bg location: ${position.latitude}');
  });

        ShakeDetector.autoStart(
          shakeThresholdGravity: 10,
          onPhoneShake: (ShakeEvent event)async {
            final now = DateTime.now();

    // Only handle shake if 2 minutes have passed since last
    if (_lastShakeTime != null &&
        now.difference(_lastShakeTime!).inMinutes < 0.5) {
      Fluttertoast.showToast(msg:"⏳ Shake ignored — Please wait 30 Seconds");
      return;
    }

    _lastShakeTime = now; 
            
if(await Vibration.hasVibrator() ?? false){
Vibration.vibrate();
if(await Vibration.hasCustomVibrationsSupport()?? false){
Vibration.vibrate(duration: 1000);
await Future.delayed(Duration(seconds: 30));
Vibration.vibrate();
}
}
getandsendSms();

        });
       print("🔄 Sending notification...");
  await flutterLocalNotificationsPlugin.show(
    818,
    "Binte Hawwa",
    "BackGround Service Enabled",
    const NotificationDetails(
      android: AndroidNotificationDetails(
        "Binte Hawwa",
        "Foreground Service",
        icon: "icons",
       ongoing: true,
          onlyAlertOnce: true, 
          // showWhen: false,
      ),
    ),
  );
    }
   
    }
  }
  );
}
DateTime? _lastShakeTime;
 Position? _currentPosition;
  LocationPermission? permission;
  Telephony? telephony = Telephony.instance;
  _isPermissionGranted() async => await Permission.sms.status.isGranted;
  _sendSms(String phoneNumber, String message,) async {
    try{
    await telephony!.sendSms(
       to: phoneNumber,
      message: message,
      
    );
   Fluttertoast.showToast(msg: "Message Sent Successfully");
} catch (e) {
  Fluttertoast.showToast(msg: "Failed to send: ${e.toString()}");
}
  }
  getandsendSms()async{
  List<TContact> contactList=await DatabaseHelper().getContactList();
                  if(_currentPosition==null){
                    Fluttertoast.showToast(msg: "GEt Location First");
                  }
                  else
{                  String messageBody="https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}";
                  if(await _isPermissionGranted()){
                   contactList.forEach((element){
                    _sendSms("${element.number}", "I am in trouble pleace reach me out at $messageBody");
                  
                   });

                  }else{

                    Fluttertoast.showToast(msg: "Something Wrong");
                  }
}
 }
