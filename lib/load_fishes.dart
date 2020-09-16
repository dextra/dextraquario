import 'dart:convert';

import 'package:dextraquario/fish_info.dart';
import 'package:flame/flame.dart';

class LoadFishes {
  static Future<List<FishInfo>> loadFishes() async {
    String fishesString = await Flame.assets.readFile('fishes.json');
    Map fishMap = jsonDecode(fishesString);
    return fishMap['fishes']
        .map((fish) => FishInfo.fromJson(fish))
        .cast<FishInfo>()
        .toList();
  }
}
