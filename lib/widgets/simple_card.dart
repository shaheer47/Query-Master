import 'package:flutter/material.dart';

class SimpleCard extends StatelessWidget {
  Widget child;
  Color _color;

  SimpleCard({required this.child, required Color color, super.key})
      : _color = color;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      color: _color,
      child: child,
    );
  }
}
