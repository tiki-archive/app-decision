import 'package:provider/provider.dart';

import 'overlay_service.dart';
import 'overlay_view.dart';

class OverlayPresenter{
  final OverlayService service;

  OverlayPresenter(this.service);

  ChangeNotifierProvider<OverlayService> widget() {
    return ChangeNotifierProvider.value(
        value: service, child: const OverlayView());
  }
}