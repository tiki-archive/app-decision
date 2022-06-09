/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:provider/provider.dart';

import '../overlay/overlay_service.dart';
import 'screen_service.dart';
import 'screen_view_layout.dart';

class ScreenPresenter {
  final ScreenService service;

  ScreenPresenter(this.service);

  ChangeNotifierProvider<ScreenService> home() {
    return ChangeNotifierProvider.value(
        value: service, child: const ScreenViewLayout());
  }

  ChangeNotifierProvider<OverlayService> overlay() => service.overlay.presenter.widget();
}
