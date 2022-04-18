/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';

abstract class DecisionAbstractCard {
  Future<void> callbackNo(BuildContext context);

  Future<void> callbackYes(BuildContext context);

  Widget content(BuildContext context);
}
