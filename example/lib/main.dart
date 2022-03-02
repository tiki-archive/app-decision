import 'package:flutter/material.dart';
import 'package:$PACKAGE_NAME/$PACKAGE_NAME.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('$PACKAGE_NAME_CAPITAL example app'),
        ),
        body: $PACKAGE_NAME_CAPITAL().home()
        )
    );
  }
}
