import 'package:flutter/material.dart';
import 'package:notifications_demo/services/app_utils.dart';

import '../main.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _changeLanguage() {
      if(Localizations.localeOf(context).languageCode == 'ar'){
        setState(() {
          MyApp.setLocale(context, Locale("en"));
          AppUtils.saveLanguage("en");
        });
      }
      if(Localizations.localeOf(context).languageCode == 'en'){
        setState(() {
          MyApp.setLocale(context, Locale("ar"));
          AppUtils.saveLanguage("ar");
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          AppUtils.translate(context, "Home_page_title"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeLanguage,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}