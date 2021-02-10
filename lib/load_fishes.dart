import 'dart:convert';

import 'package:dextraquario/fish_info.dart';
import 'package:flame/flame.dart';
import 'package:dextraquario/services/user_service.dart';
import 'package:dextraquario/models/user_model.dart';

class LoadFishes {
  static UserServices _userServices = new UserServices();
  static Future<List<FishInfo>> loadFishes() async {
    String fishesString = await Flame.assets.readFile('fishes.json');
    Map fishMap1 = jsonDecode(fishesString);
    List<UserModel> fishesInfo = await _userServices.getFishRankings();
    var fishMap = Map.fromIterable(fishesInfo, key: (e) => e.name, value: (e) => e.score);

   
    print('---------------------');
    print(fishMap1);
    print('---------------------');
    print(fishMap);
    print('---------------------');
    return fishMap1['fishes']
        .map((fish) => FishInfo.fromJson(fish))
        .cast<FishInfo>()
        .toList();
  }
}
