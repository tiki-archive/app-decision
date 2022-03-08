import 'package:flutter/material.dart';

import '../../decision_style.dart';

class DecisionSdkSpamViewCompany extends StatelessWidget {
  final String? logo;
  final String? name;
  final String? email;
  final DecisionSdkStyle style;

  const DecisionSdkSpamViewCompany(
      {Key? key, this.logo, this.name, this.email, required this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _getAvatar(logo, name, email),
        Padding(padding: EdgeInsets.only(top: style.size(9))),
        _getCompanyName(name, email)
      ],
    );
  }

  Widget _getAvatar(String? logo, String? name, String? email) {
    return Container(
        height: style.size(9),
        width: style.size(9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: const Color(0xFFD8D8D8), width: style.text(4.5)),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Color(0x26000000),
                offset: Offset(0, 4),
                spreadRadius: 0,
                blurRadius: 12)
          ],
        ),
        child: ClipOval(
            child: logo != null
                ? Image.network(logo,
                    height: style.size(9),
                    errorBuilder: (context, error, stackTrace) =>
                        _staticAvatar())
                : _staticAvatar()));
  }

  Widget _staticAvatar() {
    String img = 'avatar1';
    String title = name ?? email ?? "";
    return Stack(children: [
      Image.asset('res/images/' + img + '.png',
        width: style.size(9),
        height: style.size(9),
        fit: BoxFit.fill,
        package: 'decision_sdk'
      ),
      Center(
        child: Text(title[0].toUpperCase(),
            style: TextStyle(
                color: const Color(0xFF00133F),
                fontSize: style.text(30),
                fontWeight: FontWeight.bold,
                fontFamily: style.textFont)),
      )
    ]);
  }

  _getCompanyName(name, email) {
    if (name != null) {
      return Text(name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              fontSize: style.text(20),
              fontWeight: FontWeight.w800,
              fontFamily: style.textFont));
    } else {
      return Text(email,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              fontSize: style.text(15),
              fontWeight: FontWeight.w800,
              fontFamily: style.textFont));
    }
  }
}
