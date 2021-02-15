import 'package:dextraquario/fish_info.dart';
import 'package:dextraquario/overlays/profile_overlay.dart';
import 'package:dextraquario/services/contribution_service.dart';
import 'package:dextraquario/services/user_service.dart';
import 'package:flutter/material.dart';

class FishOverlay extends StatelessWidget {
  final FishInfo fishInfo;
  final Function onCloseInfo;
  final UserServices _userServices = UserServices();

  FishOverlay({this.fishInfo, this.onCloseInfo});

  @override
  Widget build(context) {
    return FutureBuilder(
      future: Future.wait([
        _userServices.getUserById(fishInfo.userID),
        ContributionServices().getContributionsByUser(fishInfo.userID),
        _userServices.getUserPlacement(fishInfo.userID)
      ]),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          return ProfileScreen(
            onClose: onCloseInfo,
            user: snapshot.data[0],
            contributions: snapshot.data[1],
            userRanking: snapshot.data[2],
          );
        }

        return Container();
      },
    );
  }
}
