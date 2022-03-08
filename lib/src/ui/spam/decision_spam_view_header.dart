import 'package:flutter/material.dart';

import '../../decision_spam_service.dart';

class DecisionSdkSpamViewHeader extends StatelessWidget {
  final GlobalKey shareKey;
  final String shareMessage;
  final String provider;
  final DecisionSdkSpamService service;

  const DecisionSdkSpamViewHeader(this.service, this.shareKey, this.shareMessage, this.provider, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: service.decisionSdkService.style.size(24),
        right: service.decisionSdkService.style.size(24),
        top: service.decisionSdkService.style.size(8)),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
              child: Row(children: [
            Image.asset("res/images/$provider-round-logo.png", width: service.decisionSdkService.style.size(20)),
            Padding(padding: EdgeInsets.only(right: service.decisionSdkService.style.size(7))),
            Text(
              "Your $provider account",
              style: TextStyle(
                  fontFamily: service.decisionSdkService.style.textFont,
                  fontSize: service.decisionSdkService.style.text(12),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF797979),
            )
            )])),
          Opacity(
              opacity: 0,
              child: GestureDetector(
                  onTap: () => _share(context, shareKey, shareMessage),
                  child:
                      Icon(Icons.share, color: const Color(0xFFFF521C), size: service.decisionSdkService.style.size(24))))
        ]));
  }

  _share(BuildContext context, GlobalKey<State<StatefulWidget>> shareKey, String shareMessage) {}
}
