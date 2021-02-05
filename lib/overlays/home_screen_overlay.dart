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
  final User user;

  HomeScreenOverlay(
      {this.onGearClick,
      this.onAddClick,
      this.onUserClick,
      this.onRankingClick,
      this.user});

  @override
  Widget build(context) {
    final userModel = UserServices().getUserById(user.uid);
    return FutureBuilder(
      future: userModel,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return page(context, snapshot.data);
        } else {
          return Loading();
        }
      },
    );
  }

  Widget page(context, UserModel userModel) {
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
              padding: EdgeInsets.only(top: 23, right: 170),
              child: Text('Segundo', style: CommonText.itemTitle),
            ),

            //Primeiro lugar
            Container(
              padding: EdgeInsets.only(top: 24),
              child: Text('Primeiro', style: CommonText.itemTitle),
            ),

            //Terceiro Lugar
            Container(
              padding: EdgeInsets.only(top: 23, left: 170),
              child: Text('Terceiro', style: CommonText.itemTitle),
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

        // Botões de configurações e adicionar
        Container(
          child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Container(
                      padding: EdgeInsets.only(top: 44, right: 44),
                      child: Image.asset('images/gear.png')),
                  onTap: () {
                    onGearClick?.call();
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
                userModel.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  shadows: <Shadow>[
                    Shadow(
                        blurRadius: 0,
                        offset: Offset(1.0, 1.0),
                        color: Color.fromARGB(255, 0, 0, 0))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  userModel.score.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    shadows: <Shadow>[
                      Shadow(
                          blurRadius: 0,
                          offset: Offset(1.0, 1.0),
                          color: Color.fromARGB(255, 0, 0, 0))
                    ],
                  ),
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
}
