import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_localization.dart';

class AppUtils {
  static String firebaseToken;
  static FirebaseMessaging firebaseMesseging = FirebaseMessaging.instance;

  // language
  static String language;

  static Future<String> loadSavedLanguage() async {
    language = (await SharedPreferences.getInstance()).getString('langCode');
    return language;
  }

  static saveLanguage(String languag) async {
    print("saveLanguage  ---->>>> ${languag}");
    language = languag;
    (await SharedPreferences.getInstance()).setString('langCode', language);
  }

  static String getLanguage() {
    return language;
  }

  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static String translate(BuildContext context, String key) {
    return AppLocalization.of(context).translate(key);
  }

  static void exitFromApp() {
    exit(0);
  }
}
