/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';

import 'screen_service.dart';

class ScreenController {
  final ScreenService service;

  ScreenController(this.service);

  void removeCard(
      {required BuildContext context,
      required int index,
      Function(BuildContext context)? callback}) {
    if (callback != null) callback(context);
    service.removeCard(index);
  }
}
