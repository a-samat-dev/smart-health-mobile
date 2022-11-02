import 'package:flutter/material.dart';

class LoadingAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(scale: 0.5, child: CircularProgressIndicator());
  }
}
