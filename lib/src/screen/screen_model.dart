/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../tiki_decision_card.dart';

class ScreenModel {
  List<String> stack = [];
  Map<String, TikiDecisionCard> cards = {};
  bool isLinked;
  bool isPending;

  ScreenModel({this.isLinked = false, this.isPending = false});
}
