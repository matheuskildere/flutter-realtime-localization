import 'package:flutter/material.dart';
import 'package:flutterrealtimelocalization/app/pages/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Real Time Localization',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
