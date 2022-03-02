import 'package:provider/provider.dart';

import '../../src/$PACKAGE_NAME_service.dart';
import 'ui/$PACKAGE_NAME_home_layout.dart';

class $PACKAGE_NAME_CAPITALPresenter {
  final $PACKAGE_NAME_CAPITALService service;

  $PACKAGE_NAME_CAPITALPresenter(this.service);

  ChangeNotifierProvider<$PACKAGE_NAME_CAPITALService> home() {
    return ChangeNotifierProvider.value(
        value: service, child: const $PACKAGE_NAME_CAPITALLayout());
  }

}
