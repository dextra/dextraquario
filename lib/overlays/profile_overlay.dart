import 'dart:ui';

import 'package:dextraquario/components/close_button_widget.dart';
import 'package:dextraquario/models/contribution_model.dart';
import 'package:dextraquario/models/user_model.dart';
import 'package:dextraquario/services/contribution_service.dart';
import 'package:dextraquario/services/user_service.dart';
import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flame/widgets/sprite_widget.dart';
import 'package:flutter/material.dart';
import '../assets.dart';
import '../common.dart';

class ProfileOverlay extends StatelessWidget {
  final Function onClose;
  final String userID;
  final UserServices _userServices = UserServices();
  final ContributionServices _contributionServices = ContributionServices();

  ProfileOverlay({this.onClose, this.userID});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
        [
          _userServices.getUserById(userID),
          _contributionServices.getContributionsByUser(userID),
          _userServices.getUserPlacement(userID),
        ],
      ),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          return ProfileScreen(
            onClose: this.onClose,
            user: snapshot.data[0],
            contributions: snapshot.data[1],
            userRanking: snapshot.data[2],
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Loading...',
                    style: CommonText.panelTitle,
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final Function onClose;
  final ScrollController _scrollController = ScrollController();
  final UserModel user;
  final int userRanking;
  final List<ContributionModel> contributions;

  ProfileScreen(
      {this.onClose, this.user, this.contributions, this.userRanking});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 7,
        sigmaY: 7,
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CloseButtonWidget(onClick: onClose),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: NineTileBox(
                      image: Assets.panelImage,
                      tileSize: 12,
                      destTileSize: 36,
                      width: 976,
                      height: 736,
                      padding: EdgeInsets.only(top: 32, left: 40, right: 40),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // Photo container
                                        Container(
                                          width: 126,
                                          height: 126,
                                          child: Image.network(user.photo),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 16),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${user.name}',
                                                style:
                                                    CommonText.heightOneShadow(
                                                        20),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                  top: 8,
                                                  bottom: 20,
                                                ),
                                                child: Text(
                                                  user.score == 1
                                                      ? '1 contribuição'
                                                      : '${user.score} contribuições',
                                                  style: CommonText.itemTitle,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  ContributionNumber(
                                                    ItemType
                                                        .CONTRIBUICAO_COMUNIDADE,
                                                    contributions,
                                                  ),
                                                  ContributionNumber(
                                                    ItemType.DESAFIO_TECNICO,
                                                    contributions,
                                                  ),
                                                  ContributionNumber(
                                                    ItemType
                                                        .ENTREVISTA_PARTICIPACAO,
                                                    contributions,
                                                  ),
                                                  ContributionNumber(
                                                    ItemType
                                                        .ENTREVISTA_AVALIACAO_TESTE,
                                                    contributions,
                                                  ),
                                                  ContributionNumber(
                                                    ItemType.CAFE_COM_CODIGO,
                                                    contributions,
                                                  ),
                                                  ContributionNumber(
                                                    ItemType.ARTIGO_BLOG_DEXTRA,
                                                    contributions,
                                                  ),
                                                  ContributionNumber(
                                                    ItemType.CHAPA,
                                                    contributions,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 894,
                                    height: 471,
                                    margin: EdgeInsets.only(top: 32),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(
                                              CommonColors.boxInsetBackground),
                                        ),
                                      ],
                                      border: Common.insetBorder,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 42,
                                          color: Color(CommonColors.listHeader),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: 32,
                                              right: 54,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Contribuição',
                                                  style:
                                                      CommonText.itemSubtitle,
                                                ),
                                                Text(
                                                  'Data',
                                                  style:
                                                      CommonText.itemSubtitle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Scrollbar(
                                            isAlwaysShown: true,
                                            controller: _scrollController,
                                            child: ListView.builder(
                                              padding: EdgeInsets.only(top: 8),
                                              controller: _scrollController,
                                              itemCount: contributions.length,
                                              itemBuilder: (context, index) {
                                                return new ContributionItem(
                                                  contribution:
                                                      contributions[index],
                                                  author: user.name,
                                                  index: index,
                                                  canApprove: false,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            left: 800,
                            top: 24,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 48,
                                  width: 48,
                                  margin: EdgeInsets.only(bottom: 16),
                                  child: Image.asset(
                                    "images/${_getUserRankMedal(userRanking)}.png",
                                  ),
                                ),
                                Text(
                                  '#${userRanking}',
                                  style: CommonText.heightOneShadow(18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ContributionNumber extends StatelessWidget {
  final ItemType type;
  final List<ContributionModel> contribs;

  ContributionNumber(this.type, this.contribs);

  @override
  Widget build(BuildContext context) {
    int count = 0;

    contribs.forEach((contribution) {
      if (contribution.category.toString().split('.').last ==
          type.toString().split('.').last) count++;
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 32,
          height: 32,
          margin: EdgeInsets.only(right: 24, bottom: 8),
          child: SpriteWidget(
            sprite: Assets.ui
                .getSprite(type.toString().replaceAll('ItemType.', '')),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 24),
          child: Text(
            '${count}',
            style: CommonText.heightOneShadow(14),
          ),
        ),
      ],
    );
  }
}

String _getUserRankMedal(int rank) {
  switch (rank) {
    case 1:
      return "gold_medal";
    case 2:
      return "silver_medal48";
    case 3:
      return "bronze_medal48";
    default:
      return "wood_medal48";
  }
}
