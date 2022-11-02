import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/main_drawer.dart';

class ScreenSkeleton extends StatelessWidget {
  final Widget _widget;

  const ScreenSkeleton(this._widget, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            FaIcon(
              FontAwesomeIcons.heartPulse,
              color: Colors.red,
              size: 40,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'SH',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.question_mark_rounded))
        ],
      ),
      body: _widget,
      drawer: MainDrawer(),
    );
  }
}
