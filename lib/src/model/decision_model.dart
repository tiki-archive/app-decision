/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../ui/decision_abstract_card.dart';

class DecisionSdkModel {
  List<DecisionSdkAbstractCard> cards = [];
  bool isLinked = false;
  bool isPending = false;
  bool isTestDone = false;
  bool testCardsAdded = false;
}
