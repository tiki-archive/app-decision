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
  int indexedEmails;
  int fetchedEmails;

  ScreenModel({
    this.isLinked = false,
    this.isPending = false,
    this.indexedEmails = 0,
    this.fetchedEmails = 0
  });
}
