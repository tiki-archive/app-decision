/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_style/tiki_style.dart';

import 'screen_service.dart';

class ScreenViewLayoutEmpty extends StatelessWidget {
  static const String _noMore = "No more data decisions.\n";
  static const String _party = "You can now go party!";
  static const String _notNow =
      "we’re working on\ngetting your data in this space";
  static const String _justASec = "Just a sec, ";

  static const double _fontSize = 15;

  const ScreenViewLayoutEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenService service = Provider.of<ScreenService>(context);
    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(top: SizeProvider.instance.size(100)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
              height: SizeProvider.instance.size(115),
              child: FittedBox(
                child: ImgProvider.pineappleFloatie,
                fit: BoxFit.fitHeight,
              )),
          Padding(
              padding: EdgeInsets.only(top: SizeProvider.instance.size(16)),
              child: service.model.isPending
                  ? RichText(
                      text: TextSpan(
                          text: _justASec,
                          style: TextStyle(
                              fontFamily: TextProvider.familyNunitoSans,
                              package: 'style',
                              fontSize: SizeProvider.instance.text(_fontSize),
                              color: const Color(0xFF0036B5),
                              fontWeight: FontWeight.bold),
                          children: [
                          TextSpan(
                              text: _notNow,
                              style: TextStyle(
                                  fontFamily: TextProvider.familyNunitoSans,
                                  package: 'style',
                                  fontSize:
                                      SizeProvider.instance.text(_fontSize),
                                  color: const Color(0xFF00133F),
                                  fontWeight: FontWeight.bold))
                        ]))
                  : RichText(
                      text: TextSpan(
                          text: _noMore,
                          style: TextStyle(
                              fontFamily: TextProvider.familyNunitoSans,
                              package: 'style',
                              fontSize: SizeProvider.instance.text(_fontSize),
                              color: const Color(0xFF0036B5),
                              fontWeight: FontWeight.bold),
                          children: [
                          TextSpan(
                              text: _party,
                              style: TextStyle(
                                  fontFamily: TextProvider.familyNunitoSans,
                                  package: 'style',
                                  fontSize:
                                      SizeProvider.instance.text(_fontSize),
                                  color: const Color(0xFF00133F),
                                  fontWeight: FontWeight.bold))
                        ])))
        ]));
  }
}