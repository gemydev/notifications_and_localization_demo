import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notifications_demo/services/app_localization.dart';
import 'package:notifications_demo/services/app_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(
      languageCode:
          (await SharedPreferences.getInstance()).getString('langCode') ?? 'ar',
    ),
  );
}

class MyApp extends StatefulWidget {
  final String languageCode;

  const MyApp({Key key, this.languageCode}) : super(key: key);

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setState(() {
      state._locale = locale;
    });
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  @override
  void initState() {
    super.initState();

    setLanguage();
  }

  setLanguage() async {
    _locale = Locale(widget.languageCode);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App",
      debugShowCheckedModeBanner: false,
      locale: _locale,
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('ar'), // Arabic
      ],
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Builder(
        builder: (context) {
          return Directionality(
            child: MyHomePage(
              title: "${AppUtils.translate(context, 'home_page_title')}",
            ),
            textDirection: Localizations.localeOf(context).languageCode == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr,
          );
        },
      ),
    );
  }
}
