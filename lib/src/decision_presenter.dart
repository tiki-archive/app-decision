import 'package:provider/provider.dart';

import '../../src/decision_service.dart';
import 'ui/decision_layout.dart';

class DecisionSdkPresenter {
  final DecisionSdkService service;

  DecisionSdkPresenter(this.service);

  ChangeNotifierProvider<DecisionSdkService> home() {
    return ChangeNotifierProvider.value(
        value: service, child: const DecisionSdkLayout());
  }
}
