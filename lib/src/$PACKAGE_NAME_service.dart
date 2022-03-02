import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';

import 'model/$PACKAGE_NAME_model.dart';
import '$PACKAGE_NAME_controller.dart';
import '$PACKAGE_NAME_presenter.dart';
import '$PACKAGE_NAME_style.dart';

class $PACKAGE_NAME_CAPITALService extends ChangeNotifier {
  final Logger _log = Logger('$PACKAGE_NAME_CAPITALService');
  
  late final $PACKAGE_NAME_CAPITALModel model;
  late final $PACKAGE_NAME_CAPITALPresenter presenter;
  late final $PACKAGE_NAME_CAPITALController controller;
  late final $PACKAGE_NAME_CAPITALStyle style;

  $PACKAGE_NAME_CAPITALService({required this.style}) {
    presenter = $PACKAGE_NAME_CAPITALPresenter(this);
    model = $PACKAGE_NAME_CAPITALModel();
    controller = $PACKAGE_NAME_CAPITALController(this);
  }
}
