import 'dart:ui';

import 'package:dextraquario/assets.dart';
import 'package:dextraquario/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dextraquario/common.dart';
import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'package:dextraquario/widgets/loading.dart';
import 'package:dextraquario/utils/scale_factor_calculator.dart';

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

    return LayoutBuilder(
      builder: (context, constraints) {
        var scaleFactor = ScaleFactorCalculator.calcScaleFactor(
            constraints.maxWidth, constraints.maxHeight);
        return FutureBuilder(
          future: Future.wait([userModel, topUsersList]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              return page(
                  context, snapshot.data[0], snapshot.data[1], scaleFactor);
            } else {
              return Loading();
            }
          },
        );
      },
    );
  }

  Widget page(context, UserModel userModel, List<UserModel> topUsersList,
      double scaleFactor) {
    return Stack(children: [
      // Painel do ranking
      GestureDetector(
          onTap: () => onRankingClick?.call(),
          child: Stack(
            children: [
              Container(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Positioned(
                        top: 0,
                        right: 720 * scaleFactor,
                        child: Image.asset(
                          'images/ranking_panel.png',
                          scale: 1 / scaleFactor,
                        ),
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
                    width: 280 * scaleFactor,
                    padding: EdgeInsets.only(
                        top: 24 * scaleFactor, left: 26 * scaleFactor),
                    child: Text(topUsersList[1].getShortName(),
                        textScaleFactor: scaleFactor,
                        style: CommonText.itemText),
                  ),

                  //Primeiro lugar
                  Container(
                    width: 175 * scaleFactor,
                    padding: EdgeInsets.only(
                        top: 24 * scaleFactor, left: 20 * scaleFactor),
                    child: Text(topUsersList[0].getShortName(),
                        textScaleFactor: scaleFactor,
                        style: CommonText.itemTitle),
                  ),

                  //Terceiro Lugar
                  Container(
                    width: 280 * scaleFactor,
                    padding: EdgeInsets.only(
                        top: 24 * scaleFactor, left: 132 * scaleFactor),
                    child: Text(topUsersList[2].getShortName(),
                        textScaleFactor: scaleFactor,
                        style: CommonText.itemText),
                  ),
                ],
              ),

              //Medalhas
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 14 * scaleFactor, right: 740 * scaleFactor),
                    child: Image.asset(
                      'images/silver_medal33.png',
                      scale: 1 / scaleFactor,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 8 * scaleFactor, right: 200 * scaleFactor),
                    child: Image.asset(
                      'images/gold_medal.png',
                      scale: 1 / scaleFactor,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 14 * scaleFactor, left: 380 * scaleFactor),
                    child: Image.asset('images/bronze_medal33.png',
                        scale: 1 / scaleFactor),
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
                            padding: EdgeInsets.only(
                                top: 44 * scaleFactor, right: 44 * scaleFactor),
                            child: Image.asset('images/closeButton48.png',
                                scale: 1 / scaleFactor)),
                        onTap: () {
                          onLogoutClick?.call();
                        },
                      ),
                      GestureDetector(
                        child: Container(
                            padding: EdgeInsets.only(
                                bottom: 111.0 * scaleFactor,
                                right: 89.0 * scaleFactor),
                            child: Image.asset('images/add_button.png',
                                scale: 1 / scaleFactor)),
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
                            padding: EdgeInsets.only(
                                top: 44 * scaleFactor, left: 44 * scaleFactor),
                            child: Image.asset(
                              'images/gear.png',
                              scale: 1 / scaleFactor,
                            )),
                        onTap: () {
                          onGearClick?.call();
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Painel do canto inferior esquerdo
              GestureDetector(
                onTap: () => onUserClick?.call(),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 108 * scaleFactor,
                      left: 192 * scaleFactor,
                      child: NineTileBox(
                        image: Assets.panelImage,
                        tileSize: 12,
                        destTileSize: 16,
                        width: 288 * scaleFactor,
                        height: 80 * scaleFactor,
                      ),
                    ),
                    Positioned(
                      bottom: 128 * scaleFactor,
                      left: 222 * scaleFactor,
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
                ),
              ),
            ],
          ))
    ]);
  }

  String contributionPlural(int score) {
    if (score == 1) {
      return "Contribuição";
    } else {
      return "Contribuições";
    }
  }
}
