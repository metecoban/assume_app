import 'package:flutter/material.dart';

class PlusWidget extends StatefulWidget {
  const PlusWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PlusWidgetState createState() => _PlusWidgetState();
}

class _PlusWidgetState extends State<PlusWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
