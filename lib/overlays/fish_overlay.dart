import 'package:dextraquario/fish_info.dart';
import 'package:dextraquario/overlays/profile_overlay.dart';
import 'package:dextraquario/services/contribution_service.dart';
import 'package:dextraquario/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FishOverlay extends StatelessWidget {
  final FishInfo fishInfo;
  final Function onCloseInfo;

  FishOverlay({this.fishInfo, this.onCloseInfo});

  @override
  Widget build(context) {
    return FutureBuilder(
      future: Future.wait([
        UserServices().getUserById(fishInfo.userID),
        ContributionServices().getContributionsByUser(fishInfo.userID),
      ]),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          return ProfileScreen(
            onClose: onCloseInfo,
            user: snapshot.data[0],
            contributions: snapshot.data[1],
            userRanking: 1,
          );
        }

        return Container();
      },
    );
  }
}
