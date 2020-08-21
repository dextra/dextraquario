import 'package:flutter/material.dart';
import 'package:flame/flame.dart';

import './dextra_quario.dart';
import './components/fish.dart';

void main() async {
  final screenSize = await Flame.util.initialDimensions();
  final game = DextraQuario(screenSize);

  // Mocking some fishs
  game.add(
      Fish()
      ..x = 100
      ..y = 100
  );

  game.add(
      Fish()
      ..x = 300
      ..y = 300
  );

  runApp(game.widget);
}
