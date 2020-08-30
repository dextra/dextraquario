import 'package:dextraquario/load_fishes.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';

import './dextra_quario.dart';
import './components/fish.dart';
import './assets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final screenSize = await Flame.util.initialDimensions();
  await Assets.load();

  final fishes = await LoadFishes.loadFishes();
  final game = DextraQuario(screenSize, fishes.length);

  fishes.forEach((fishInfo) {
    game.add(Fish(fishInfo: fishInfo));
  });

  runApp(MaterialApp(
    home: Scaffold(
      body: game.widget,
    ),
  ));
}
