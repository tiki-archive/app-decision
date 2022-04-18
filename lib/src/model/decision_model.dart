/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../ui/decision_abstract_card.dart';

class DecisionModel {
  List<DecisionAbstractCard> cards = [];
  bool isLinked = false;
  bool isPending = false;
  bool isTestDone = false;
  bool testCardsAdded = false;
}
