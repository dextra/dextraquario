import 'package:dextraquario/fish_info.dart';
import 'package:dextraquario/services/fish_service.dart';
import 'package:dextraquario/services/user_service.dart';
import 'package:dextraquario/models/user_model.dart';

class LoadFishes {
  static UserServices _userServices = new UserServices();

  static Future<List<FishInfo>> loadFishes() async {
    List<UserModel> users = await _userServices.getAll();
    List<FishInfo> fishes = [];

    for(var user in users) {
      FishServices fishService = FishServices(user);
      await fishService.loadFishInfo();

      if(!fishService.contributions.isEmpty)
        fishes.add(FishInfo.fromJson(fishService.toJson()));
    }

    return fishes;
  }
}
