
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale locale;
  Map<String, Object> _phrases;

  AppLocalization(this.locale);

  // Getter of Localization
  static AppLocalization of(BuildContext context) =>
      Localizations.of<AppLocalization>(context, AppLocalization);

  // Data Loader
  Future<bool> load() async {
    String data = await rootBundle
        .loadString('assets/lang/${this.locale.languageCode}.json');
    this._phrases = json.decode(data);
    return true;
  }

  // Localize Some Text
  String translate(String key) {
    return this._phrases[key] ?? key;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localizations = new AppLocalization(locale);
    await localizations.load();
    print("Load ${locale.languageCode}");
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}