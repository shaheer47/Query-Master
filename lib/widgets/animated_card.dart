import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedCard extends StatefulWidget {

  final Widget child;
  final List<Color> colors;
  final Duration duration;

  const AnimatedCard({
    super.key,
    required this.child,
    required this.colors,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> with SingleTickerProviderStateMixin {
  // List of colors to cycle through
  late List<Color> _colors;

  // Index to track the current color in the list
  int _currentColorIndex = 0;

  // Controller for animation duration
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _colors = widget.colors;
    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    // Start the timer to change colors automatically
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      _changeColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _animationController.duration!,
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: _colors[_currentColorIndex],
        borderRadius: BorderRadius.circular(15.0),
      ),
      width: 200.0,
      height: 150.0,
      child: Center(
        child: Text(
          'Your Content',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Function to change the color
  void _changeColor() {
    setState(() {
      _currentColorIndex = (_currentColorIndex + 1) % _colors.length;
      _animationController.reset();
      _animationController.forward();
    });
  }
}
