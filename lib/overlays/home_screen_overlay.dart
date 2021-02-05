import 'dart:ui';

import 'package:dextraquario/assets.dart';
import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flutter/material.dart';

class HomeScreenOverlay extends StatelessWidget {
  final Function onGearClick;
  final Function onAddClick;
  final Function onUserClick;
  final Function onRankingClick;

  HomeScreenOverlay(
      {this.onGearClick,
      this.onAddClick,
      this.onUserClick,
      this.onRankingClick});

  @override
  Widget build(context) {
    return Stack(children: [
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

      //Primeiro lugar
      Positioned(
        top: 24,
        left: 645,
        child: Text(
          'Primeiro',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            shadows: <Shadow>[
              Shadow(
                blurRadius: 0,
                offset: Offset(4.0, 4.0),
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
        ),
      ),

      // Segundo lugar
      Positioned(
        top: 23,
        left: 363,
        child: Text(
          'Segundo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            shadows: <Shadow>[
              Shadow(
                blurRadius: 0,
                offset: Offset(4.0, 4.0),
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
        ),
      ),

      //Terceiro Lugar
      Positioned(
        top: 23,
        left: 928,
        child: Text(
          'Terceiro',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            shadows: <Shadow>[
              Shadow(
                blurRadius: 0,
                offset: Offset(4.0, 4.0),
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
        ),
      ),

      //Medalhas
      Positioned(
        top: 8,
        left: 589,
        child: Image.asset('images/gold_medal.png'),
      ),
      Positioned(
        top: 14,
        left: 327,
        child: Image.asset('images/silver_medal.png'),
      ),
      Positioned(
        top: 14,
        left: 892,
        child: Image.asset('images/bronze_medal.png'),
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
      GestureDetector(
        child: Container(
          padding: EdgeInsets.only(right: 478, bottom: 103),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NineTileBox(
                  image: Assets.userEmptyImage,
                  tileSize: 16,
                  destTileSize: 24,
                  width: 96,
                  height: 96,
                ),
                NineTileBox(
                  image: Assets.panelImage,
                  tileSize: 12,
                  destTileSize: 16,
                  width: 288,
                  height: 80,
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          onUserClick?.call();
        },
      )
    ]);
  }
}
