/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:decision_sdk/src/decision_style.dart';
import 'package:decision_sdk/src/model/security_score_modal_model.dart';
import 'package:flutter/material.dart';
import 'security_score_modal_view_button.dart';
import 'security_score_modal_view_desc.dart';
import 'security_score_modal_view_explain.dart';
import 'security_score_modal_view_score.dart';

class SecurityScoreModalLayout extends StatelessWidget {
  static const String _title = 'Security score';

  final SecurityScoreModalModel model;
  final DecisionSdkStyle style;

  const SecurityScoreModalLayout(this.model, this.style, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: SafeArea(
            child: Container(
                height: MediaQuery.of(context).size.height * 0.85,
                margin: EdgeInsets.symmetric(horizontal: style.size(20)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: style.size(20)),
                          child: Center(
                              child: Container(
                                  height: style.size(4),
                                  width: style.size(62),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(style.size(8))),
                                      color: const Color(0xFFD8D8D8))))),
                      Container(
                          margin: EdgeInsets.only(top: style.size(4)),
                          alignment: Alignment.center,
                          child: Text(
                            _title,
                            style: TextStyle(
                                color: const Color(0xFF00133F),
                                fontSize: style.text(15),
                                fontWeight: FontWeight.w800),
                            textAlign: TextAlign.center,
                          )),
                      Container(
                          margin: EdgeInsets.only(top: style.size(25)),
                          alignment: Alignment.topLeft,
                          child: SecurityScoreModalViewDesc(
                              style: style, noScore: model.security == null)),
                      Container(
                          margin: EdgeInsets.only(top: style.size(25)),
                          child: SecurityScoreModalViewScore(
                              style: style,
                              security: model.security,
                              hacking: model.hacking,
                              sensitivity: model.sensitivity)),
                      Container(
                          margin: EdgeInsets.only(top: style.size(25)),
                          child: SecurityScoreModalViewExplain(style: style)),
                      Expanded(
                          child: Container(
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.only(bottom: style.size(25)),
                              child:
                                  SecurityScoreModalViewButton(style: style)))
                    ]))));
  }
}
