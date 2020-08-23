import 'package:dextraquario/load_fishes.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';

import 'dart:math';
import './dextra_quario.dart';
import './components/fish.dart';
import './assets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final screenSize = await Flame.util.initialDimensions();
  final game = DextraQuario(screenSize);

  await Assets.load();

  final fishes = await LoadFishes.loadFishes();

  final Random random = Random();

  fishes.forEach((fishInfo) {
    game.add(Fish(fishInfo: fishInfo)
      ..x = random.nextDouble() * screenSize.width
      ..y = random.nextDouble() * screenSize.height);
  });

  runApp(game.widget);
}
