import 'package:decision_sdk/src/decision_service.dart';
import 'package:decision_sdk/src/decision_style.dart';
import 'package:decision_sdk/src/model/security_score_modal_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DecisionSdkSpamViewSecurity extends StatelessWidget {
  final double? security;
  final double? sensitivity;
  final double? hacking;
  final DecisionSdkStyle style;

  const DecisionSdkSpamViewSecurity(
      {Key? key, double? security, this.sensitivity, this.hacking, required this.style})
      : security = security != null ? (1 - security) * 5 : null, super(key: key);

  @override
  Widget build(BuildContext context) {
    DecisionSdkService service = Provider.of<DecisionSdkService>(context);
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: _getStars(service)),
      Padding(
        padding: EdgeInsets.only(top: service.style.size(4)),
      ),
      security != null
          ? RichText(
              text: TextSpan(
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: style.bigTxtFontFamily,
                      color: const Color(0xFF8D8D8D),
                      fontSize: style.text(15)),
                  text: "Your data is ",
                  children: [
                    TextSpan(
                        text: _getSecurityText(security ?? 0),
                        style: TextStyle(color: _getColorForText())),
                    _getInfoIcon(context, service)
                  ]),
            )
          : RichText(
              text: TextSpan(
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: style.bigTxtFontFamily,
                      color: const Color(0xFF8D8D8D),
                      fontSize: style.text(15)),
                  text: "No data score info yet",
                  children: [_getInfoIcon(context, service)]),
            ),
    ]);
  }

  List<Widget> _getStars(DecisionSdkService service) {
    var color = _getColor();
    var starRate = security ?? 0;
    var stars = <Widget>[];
    for (int i = 0; i < 5; i++) {
      if (i >= starRate.floor() && i < starRate.ceil()) {
        stars.add(Padding(
            padding: EdgeInsets.symmetric(horizontal: service.style.size(4)),
            child: Stack(children: [
              Image.asset("res/images/star-grey.png", width: service.style.size(20)),
              ClipRect(
                child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.5,
                    child: Image.asset("res/images/star-$color.png", package: 'decision', width: service.style.size(20))),
              ),
            ])));
      } else if (i >= starRate.ceil()) {
        stars.add(Padding(
            padding: EdgeInsets.symmetric(horizontal: service.style.size(2)),
            child: Image.asset("res/images/star-grey.png", package: 'decision', width: service.style.size(20))));
      } else {
        stars.add(Padding(
            padding: EdgeInsets.symmetric(horizontal: service.style.size(2)),
            child: Image.asset("res/images/star-$color.png", package: 'decision', width: service.style.size(20))));
      }
    }
    return stars;
  }

  String _getColor() {
    if (security == null) {
      return "grey";
    } else {
      var starRate = security ?? 0;
      if (starRate < 2) {
        return "red";
      } else if (starRate < 4) {
        return "yellow";
      } else {
        return "green";
      }
    }
  }

  Color _getColorForText() {
    var starRates = security ?? 0;
    if (security == null) {
      return const  Color(0xFF797979);
    } else {
      if (starRates < 2) {
        return const Color(0xFFC73000);
      } else if (starRates < 4) {
        return const Color(0xFFE89933);
      } else {
        return const Color(0xFF00B272);
      }
    }
  }

  String _getSecurityText(num starRate) {
    if (starRate < 2) {
      return "not safe";
    } else if (starRate < 4) {
      return "somewhat safe";
    } else {
      return "very safe";
    }
  }

  _getInfoIcon(BuildContext context, DecisionSdkService service) {
    return WidgetSpan(
        child: Padding(
            padding: EdgeInsets.only(
              left: service.style.size(13),
            ),
            child: GestureDetector(
                child: Icon(
                  Icons.info_outline_rounded,
                  color: const Color(0xFF8D8D8D),
                  size: style.text(17),
                ),
                onTap: () => service.presenter.showModal(
                  context,
                  SecurityScoreModalModel(
                        hacking: hacking,
                        sensitivity: sensitivity,
                        security: security))
                        )));
  }
}
