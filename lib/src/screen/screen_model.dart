/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../tiki_decision_card.dart';

class ScreenModel {
  List<TikiDecisionCard> cards = [];
  bool isLinked = false;
  bool isPending = false;
  bool isTestDone = false;
  bool testCardsAdded = false;
}
