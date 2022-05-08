/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:tiki_decision/tiki_decision.dart';
import 'package:tiki_kv/tiki_kv.dart';
import 'package:tiki_style/tiki_style.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Database database = await openDatabase('${Uuid().v4()}.db');
  TikiKv tikiKv = await TikiKv(database: database).init();
  TikiDecision decision =
      await TikiDecision(tikiKv: tikiKv, isConnected: true).init();

  runApp(MaterialApp(
    title: 'Decision Example',
    theme: ThemeData(),
    home: Scaffold(
      body: Center(child: Widgety(decision)),
    ),
  ));
}

class Widgety extends StatelessWidget {
  final TikiDecision decision;

  Widgety(this.decision);

  @override
  Widget build(BuildContext context) {
    TikiStyle style = TikiStyle.init(context);
    return decision.widget;
  }
}
