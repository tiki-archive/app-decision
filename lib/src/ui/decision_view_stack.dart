import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../decision_service.dart';

class DecisionSdkViewStack extends StatelessWidget {
  final List<Widget> children;
  final Widget noCardsPlaceholder;

  const DecisionSdkViewStack(
      {Key? key, required this.noCardsPlaceholder, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DecisionSdkService service = Provider.of<DecisionSdkService>(context);
    return Container(
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(service.style.size(15)))),
        width: double.infinity,
        child: Stack(clipBehavior: Clip.none, children: [
          noCardsPlaceholder,
          ...children,
        ]));
  }
}
