import 'package:flutter/material.dart';

class AppVerticalDivider extends StatelessWidget {
  const AppVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent, // ponta esquerda
            Colors.amber, // centro
            Colors.transparent, // ponta direita
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
    );
  }
}
