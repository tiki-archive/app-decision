/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:decision_sdk/src/decision_service.dart';
import 'package:logging/logging.dart';

import 'model/decision_card_spam_model.dart';
import 'ui/spam/decision_spam_layout.dart';

class DecisionSdkSpamService {
  final _log = Logger('DecisionSdkSpamService');
  final DecisionSdkService decisionSdkService;

  DecisionSdkSpamService(this.decisionSdkService);

  Future<void> addCards({
      required String provider,
      required List<dynamic> messages,
      required unsubscribeCallback,
      required keepCallback}) async {
    List<DecisionSdkSpamModel> spamModels = [];
    spamModels.add(DecisionSdkSpamModel(
      logoUrl: messages[0].sender?.company?.logo,
      category: messages[0].sender?.category,
      companyName: messages[0].sender?.name,
      frequency: _calculateFrequency(messages),
      openRate: _calculateOpenRate(messages),
      securityScore: messages[0].sender?.company?.securityScore,
      sensitivityScore: messages[0].sender?.company?.sensitivityScore,
      hackingScore: messages[0].sender?.company?.breachScore,
      senderId: messages[0].sender.senderId,
      senderEmail: messages[0].sender?.email,
      totalEmails: messages.length,
      sinceYear: messages[0].sender?.emailSince?.year.toString(),
      provider: provider,
    ));
    decisionSdkService.addCards(spamModels
        .map((spamModel) => DecisionSdkSpamLayout(this, spamModel))
        .toList());
  }

  String _calculateFrequency(List<dynamic> messages) {
    const int secsInDay = 86400;
    const int secsInWeek = 604800;
    const int secsInMonth = 2629746;

    if (messages.length == 1) return "once";

    messages.sort((a, b) => a.receivedDate!.isBefore(b.receivedDate!) ? -1 : 1);
    List<Duration> freq = [];
    for (int i = 0; i < messages.length - 1; i++) {
      freq.add(
          messages[i].receivedDate!.difference(messages[i + 1].receivedDate!));
    }
    double avgSeconds = 0;
    freq.map((f) => f.inSeconds).forEach((f) => avgSeconds += f);
    avgSeconds = (avgSeconds / freq.length).abs();

    if (avgSeconds <= secsInDay) {
      return "daily";
    } else if (avgSeconds <= secsInWeek) {
      return "weekly";
    } else if (avgSeconds <= secsInMonth) {
      return "monthly";
    } else if (avgSeconds <= secsInMonth * 3) {
      return "quarterly";
    } else if (avgSeconds <= secsInMonth * 6) {
      return "semiannually";
    } else {
      return "annually";
    }
  }

  double _calculateOpenRate(List<dynamic> messages) {
    int opened = 0;
    int total = messages.length;
    for (var message in messages) {
      if (message.openedDate != null) opened++;
    }
    return opened / total;
  }
}
