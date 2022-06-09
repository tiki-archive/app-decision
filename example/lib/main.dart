/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:example/widgety.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:tiki_decision/tiki_decision.dart';
import 'package:tiki_kv/tiki_kv.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Database database = await openDatabase('${const Uuid().v4()}.db');
  TikiKv tikiKv = await TikiKv(database: database).init();
  TikiDecision decision =
      await TikiDecision(tikiKv: tikiKv, isLinked: true).init();
  runApp(MaterialApp(
    title: 'Decision Example',
    theme: ThemeData(),
    home: Scaffold(
      body: Stack(children: [
        Widgety(decision),
        decision.overlay,
      ]
    ),
  )));
}
