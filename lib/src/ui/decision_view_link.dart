/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../decision_service.dart';

class DecisionSdkViewLink extends StatelessWidget {
  static const String _add = "Add an email account";
  static const String _choices = "to start making choices";

  const DecisionSdkViewLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DecisionSdkService service = Provider.of<DecisionSdkService>(context);
    return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      Image(
        image: const AssetImage('res/images/pineapple-cry.png',
            package: 'decision_sdk'),
        height: service.style.size(120),
        fit: BoxFit.fitHeight,
      ),
      Padding(
          padding: EdgeInsets.only(top: service.style.size(10)),
          child: Text(_add,
              style: TextStyle(
                  fontFamily: service.style.bigTxtFontFamily,
                  fontSize: service.style.text(15),
                  color: const Color(0xFFE89933),
                  fontWeight: FontWeight.bold))),
      Padding(
          padding: EdgeInsets.only(top: service.style.size(3)),
          child: Text(_choices,
              style: TextStyle(
                  fontFamily: service.style.bigTxtFontFamily,
                  fontSize: service.style.text(15),
                  color: const Color(0xFF00133F),
                  fontWeight: FontWeight.bold)))
    ]));
  }
}
