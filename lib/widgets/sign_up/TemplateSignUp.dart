import 'package:flutter/material.dart';

class TemplateSignUp extends StatelessWidget {
  final List<Widget> _widgets;

  const TemplateSignUp(this._widgets, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      const Text('Sign Up Form',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26))
    ];

    for (var element in _widgets) {
      children.add(const Padding(padding: EdgeInsets.only(bottom: 20)));
      children.add(element);
    }

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      child: Column(
        children: children,
      ),
    );
  }
}
