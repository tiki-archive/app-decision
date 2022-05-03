/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';

abstract class TikiDecisionCard {
  Future<void> callbackNo();

  Future<void> callbackYes();

  Widget content();
}
