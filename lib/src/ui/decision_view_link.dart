/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:style/style.dart';


class DecisionViewLink extends StatelessWidget {
  static const String _add = "Add an email account";
  static const String _choices = "to start making choices";

  const DecisionViewLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        child: FittedBox(
          child: ImgProvider.pineappleCry,
          fit: BoxFit.fitHeight),
        height: SizeProvider.instance.size(120),
      ),
      Padding(
          padding: EdgeInsets.only(top: SizeProvider.instance.size(10)),
          child: Text(_add,
              style: TextStyle(
                  fontFamily: SizeProvider.instance.bigTxtFontFamily,
                  fontSize: SizeProvider.instance.text(15),
                  color: const Color(0xFFE89933),
                  fontWeight: FontWeight.bold))),
      Padding(
          padding: EdgeInsets.only(top: SizeProvider.instance.size(3)),
          child: Text(_choices,
              style: TextStyle(
                  fontFamily: SizeProvider.instance.bigTxtFontFamily,
                  fontSize: SizeProvider.instance.text(15),
                  color: const Color(0xFF00133F),
                  fontWeight: FontWeight.bold)))
    ]));
  }
}
