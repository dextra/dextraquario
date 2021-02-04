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
      // Painel do ranking esquerdo
      Container(
        child: Align(
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(right: 586),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Image.asset('images/ranking_left_pannel72px.png'),
                        Container(
                          padding: EdgeInsets.only(top: 14, left: 27),
                          child: Image.asset('images/silver_medal.png'),
                        ),
                      ],
                    ),
                    Container(
                      child: Image.asset('images/ranking_center_panel72px.png'),
                    ),
                    Container(
                      child: Image.asset('images/ranking_center_panel72px.png'),
                    ),
                    Container(
                      child: Image.asset('images/ranking_center_panel72px.png'),
                    ),
                    Container(
                      child: Text(
                        'Marcio Souza',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          shadows: <Shadow>[
                            Shadow(
                              blurRadius: 0,
                              offset: Offset(4.0, 4.0),
                              color: Color.fromARGB(255, 0, 0, 0),
                            )
                          ],
                        ),
                      ),
                      padding: EdgeInsets.only(bottom: 12),
                      transform: Matrix4.translationValues(-220, 0, 0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Painel do ranking direito
      Container(
        child: Align(
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 586),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Image.asset('images/ranking_center_pannel72px.png'),
                        Container(
                          padding: EdgeInsets.only(top: 14, right: 0),
                          child: Image.asset('images/bronze_medal.png'),
                        ),
                      ],
                    ),
                    Container(
                      child: Image.asset('images/ranking_center_panel72px.png'),
                    ),
                    Container(
                      child: Image.asset('images/ranking_center_panel72px.png'),
                    ),
                    Container(
                      child: Image.asset('images/ranking_right_panel72px.png'),
                    ),
                    Container(
                      child: Text(
                        'Adriano Maringolo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          shadows: <Shadow>[
                            Shadow(
                              blurRadius: 0,
                              offset: Offset(4.0, 4.0),
                              color: Color.fromARGB(255, 0, 0, 0),
                            )
                          ],
                        ),
                      ),
                      padding: EdgeInsets.only(bottom: 12),
                      transform: Matrix4.translationValues(-200, 0, 0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Painel do ranking do meio
      Container(
        child: Align(
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Image.asset('images/ranking_left_pannel.png'),
                  Container(
                    padding: EdgeInsets.only(top: 8, left: 29),
                    child: Image.asset('images/gold_medal.png'),
                  ),
                ],
              ),
              Container(
                child: Image.asset('images/ranking_center_panel.png'),
              ),
              Container(
                child: Image.asset('images/ranking_center_panel.png'),
              ),
              Container(
                child: Image.asset('images/ranking_right_panel.png'),
              ),
              Container(
                child: Text(
                  'Erick Zanardo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 0,
                        offset: Offset(4.0, 4.0),
                        color: Color.fromARGB(255, 0, 0, 0),
                      )
                    ],
                  ),
                ),
                padding: EdgeInsets.only(bottom: 15),
                transform: Matrix4.translationValues(-270, 0, 0),
              ),
            ],
          ),
        ),
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
