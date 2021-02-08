import 'dart:ui';

import 'package:dextraquario/assets.dart';
import 'package:dextraquario/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dextraquario/common.dart';
import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'package:dextraquario/widgets/loading.dart';

class HomeScreenOverlay extends StatelessWidget {
  final Function onGearClick;
  final Function onAddClick;
  final Function onUserClick;
  final Function onRankingClick;
  final Function onLogoutClick;
  final User user;

  HomeScreenOverlay({
    this.onGearClick,
    this.onAddClick,
    this.onUserClick,
    this.onRankingClick,
    this.onLogoutClick,
    this.user,
  });

  @override
  Widget build(context) {
    final userModel = UserServices().getUserById(user.uid);
    final topUsersList = UserServices().getTopUsers();
    return FutureBuilder(
      future: Future.wait([userModel, topUsersList]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return page(context, snapshot.data[0], snapshot.data[1]);
        } else {
          return Loading();
        }
      },
    );
  }

  Widget page(context, UserModel userModel, List<UserModel> topUsersList) {
    return Stack(
      children: [
        // Painel do ranking
        Container(
          child: Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Positioned(
                  top: 0,
                  right: 720,
                  child: Image.asset('images/ranking_panel.png'),
                ),
              ],
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Segundo lugar
            Container(
              width: 250,
              padding: EdgeInsets.only(top: 24, right: 96),
              child: Text(topUsersList[1].getShortName(),
                  style: CommonText.itemText),
            ),

            //Primeiro lugar
            Container(
                width: 175,
                padding: EdgeInsets.only(top: 24, left: 20),
                child: Text(topUsersList[0].getShortName(),
                    style: CommonText.itemTitle)),

            //Terceiro Lugar
            Container(
              width: 250,
              padding: EdgeInsets.only(top: 24, left: 132),
              child: Text(topUsersList[2].getShortName(),
                  style: CommonText.itemText),
            ),
          ],
        ),

        //Medalhas
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 14, right: 740),
              child: Image.asset('images/silver_medal.png'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 8, right: 200),
              child: Image.asset('images/gold_medal.png'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 14, left: 380),
              child: Image.asset('images/bronze_medal.png'),
            ),
          ],
        ),

        // Botões de logout e adicionar
        Container(
          child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Container(
                      padding: EdgeInsets.only(top: 44, right: 44),
                      child: Image.asset('images/close_button.png')),
                  onTap: () {
                    onLogoutClick?.call();
                  },
                ),
                GestureDetector(
                  child: Container(
                      padding: EdgeInsets.only(bottom: 111.0, right: 89.0),
                      child: Image.asset('images/add_button.png')),
                  onTap: () {
                    onAddClick?.call();
                  },
                )
              ],
            ),
          ),
        ),

        // Botão de configuração
        Container(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Container(
                      padding: EdgeInsets.only(top: 44, left: 44),
                      child: Image.asset('images/gear.png')),
                  onTap: () {
                    onGearClick?.call();
                  },
                ),
              ],
            ),
          ),
        ),

        // Painel do canto inferior esquerdo
        Positioned(
          bottom: 108,
          left: 192,
          child: NineTileBox(
            image: Assets.panelImage,
            tileSize: 12,
            destTileSize: 16,
            width: 288,
            height: 80,
          ),
        ),
        Positioned(
          bottom: 128,
          left: 222,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                userModel.getShortName(),
                style: CommonText.itemTitle,
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  userModel.score.toString() +
                      " " +
                      contributionPlural(userModel.score),
                  style: CommonText.itemTitle,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 100,
          left: 96,
          child: Stack(
            children: [
              NineTileBox(
                image: Assets.userEmptyBottom,
                tileSize: 16,
                destTileSize: 24,
                width: 96,
                height: 96,
              ),
              Image.network(userModel.photo),
              NineTileBox(
                image: Assets.userEmptyFrame,
                tileSize: 16,
                destTileSize: 24,
                width: 96,
                height: 96,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String contributionPlural(int score) {
    if (score == 1) {
      return "Contribuição";
    } else {
      return "Contribuições";
    }
  }
}
