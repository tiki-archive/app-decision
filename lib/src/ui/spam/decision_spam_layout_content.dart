import 'package:flutter/material.dart';
import '../../decision_spam_service.dart';
import '../../model/decision_card_spam_model.dart';
import 'decision_spam_view_company.dart';
import 'decision_spam_view_data_info_row.dart';
import 'decision_spam_view_frequency.dart';
import 'decision_spam_view_header.dart';
import 'decision_spam_view_security.dart';
import 'decision_spam_view_separator.dart';

class DecisionSdkSpamLayoutContent extends StatelessWidget {
  final GlobalKey shareKey;

  final DecisionSdkSpamModel cardSpamModel;
  final DecisionSdkSpamService service;

  const DecisionSdkSpamLayoutContent(
      this.shareKey, this.service, this.cardSpamModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          DecisionSdkSpamViewHeader(service, shareKey, "mensagem", cardSpamModel.provider),
          Padding(
              padding: EdgeInsets.only(left: service.decisionSdkService.style.size(12), right: service.decisionSdkService.style.size(12), top: service.decisionSdkService.style.size(16)),
              child: DecisionSdkSpamViewCompany(
                  logo: cardSpamModel.logoUrl,
                  name: cardSpamModel.companyName,
                  email: cardSpamModel.senderEmail, style: service.decisionSdkService.style,)),
          Expanded(
              child: Container(
                  margin: EdgeInsets.only(
                      left: service.decisionSdkService.style.size(18), right: service.decisionSdkService.style.size(18), top: service.decisionSdkService.style.size(16), bottom: service.decisionSdkService.style.size(20)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(service.decisionSdkService.style.size(16)),
                      color: const Color(0xFFF8F8F8)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: service.decisionSdkService.style.size(24)),
                            child: DecisionSdkSpamViewFrequency(
                                cardSpamModel.frequency.toString(),
                                cardSpamModel.category.toString(),
                                service.decisionSdkService.style)),
                        Padding(
                            padding: EdgeInsets.only(
                                top: service.decisionSdkService.style.size(16), left: service.decisionSdkService.style.size(25), right: service.decisionSdkService.style.size(25)),
                            child: DecisionSdkSpamViewSeparator(style: service.decisionSdkService.style)),
                        Padding(
                            padding: EdgeInsets.only(top: service.decisionSdkService.style.size(8)),
                            child: DecisionSdkSpamViewDataInfoRow(
                                cardSpamModel.sinceYear,
                                cardSpamModel.totalEmails,
                                cardSpamModel.openRate,
                                service.decisionSdkService.style)),
                        Padding(
                            padding: EdgeInsets.only(top: service.decisionSdkService.style.size(20)),
                            child: DecisionSdkSpamViewSecurity(
                              security: cardSpamModel.securityScore,
                              sensitivity: cardSpamModel.sensitivityScore,
                              hacking: cardSpamModel.hackingScore, style: service.decisionSdkService.style,
                            ))
                      ])))
        ]);
  }
}
