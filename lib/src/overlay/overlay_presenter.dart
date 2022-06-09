import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'overlay_service.dart';
import 'overlay_view.dart';
import 'overlay_view_completed.dart';
import 'overlay_view_instructions.dart';

class OverlayPresenter{
  final OverlayService service;

  OverlayPresenter(this.service);

  ChangeNotifierProvider<OverlayService> widget() {
    return ChangeNotifierProvider.value(
        value: service, child: OverlayView(_getChild()));
  }

  Widget _getChild() {
    switch(service.current){
      case 1:
        return OverlayViewInstructions();
      case 2:
        return OverlayViewCompleted();
      default:
        return Container();
    }
  }
}