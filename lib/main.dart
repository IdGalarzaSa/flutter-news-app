import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/pages/tabs_page.dart';
import 'package:flutter_news_app/src/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: "TabPage",
      routes: {
        "TabPage": (_) => TabPage(),
      },
      theme: myAppTheme,
    );
  }
}
