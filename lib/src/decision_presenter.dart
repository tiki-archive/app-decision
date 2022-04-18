import 'package:provider/provider.dart';

import '../../src/decision_service.dart';
import 'ui/decision_layout.dart';

class DecisionPresenter {
  final DecisionService service;

  DecisionPresenter(this.service);

  ChangeNotifierProvider<DecisionService> home() {
    return ChangeNotifierProvider.value(
        value: service, child: const DecisionLayout());
  }
}
