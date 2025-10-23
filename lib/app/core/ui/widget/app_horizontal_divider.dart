import 'package:flutter/material.dart';

class AppHorizantalDivider extends StatelessWidget {
  const AppHorizantalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
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
