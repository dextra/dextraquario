import 'package:dextraquario/components/close_button_widget.dart';
import 'package:dextraquario/models/contribution_model.dart';
import 'package:dextraquario/models/user_model.dart';
import 'package:dextraquario/services/contribution_service.dart';
import 'package:dextraquario/services/user_service.dart';
import 'package:dextraquario/utils/scale_factor_calculator.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        var scaleFactor = ScaleFactorCalculator.calcScaleFactor(
            constraints.maxWidth, constraints.maxHeight);
        return FutureBuilder(
          future: Future.wait([
            _userServices.getUserById(userID),
            _contributionServices.getContributionsByUser(userID),
            _userServices.getUserPlacement(userID),
          ]),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              return ProfileScreen(
                  onClose: this.onClose,
                  user: snapshot.data[0],
                  contributions: snapshot.data[1],
                  userRanking: snapshot.data[2],
                  scaleFactor: scaleFactor);
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
                        textScaleFactor: scaleFactor,
                        style: CommonText.panelTitle,
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        );
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
  double scaleFactor;

  ProfileScreen(
      {this.onClose,
      this.user,
      this.contributions,
      this.userRanking,
      this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
                    destTileSize: 36 * scaleFactor,
                    width: 976 * scaleFactor,
                    height: 736 * scaleFactor,
                    padding: EdgeInsets.only(
                        top: 32 * scaleFactor,
                        left: 40 * scaleFactor,
                        right: 40 * scaleFactor),
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
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20 * scaleFactor),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Photo container
                                      Container(
                                        width: 126 * scaleFactor,
                                        height: 126 * scaleFactor,
                                        child: Image.network(user.photo),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 16 * scaleFactor),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${user.name}',
                                              textScaleFactor: scaleFactor,
                                              style: CommonText.heightOneShadow(
                                                  20),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                top: 8 * scaleFactor,
                                                bottom: 20 * scaleFactor,
                                              ),
                                              child: Text(
                                                user.score == 1
                                                    ? '1 contribuição'
                                                    : '${user.score} contribuições',
                                                textScaleFactor: scaleFactor,
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
                                                    scaleFactor),
                                                ContributionNumber(
                                                    ItemType.DESAFIO_TECNICO,
                                                    contributions,
                                                    scaleFactor),
                                                ContributionNumber(
                                                    ItemType
                                                        .ENTREVISTA_PARTICIPACAO,
                                                    contributions,
                                                    scaleFactor),
                                                ContributionNumber(
                                                    ItemType
                                                        .ENTREVISTA_AVALIACAO_TESTE,
                                                    contributions,
                                                    scaleFactor),
                                                ContributionNumber(
                                                    ItemType.CAFE_COM_CODIGO,
                                                    contributions,
                                                    scaleFactor),
                                                ContributionNumber(
                                                    ItemType.ARTIGO_BLOG_DEXTRA,
                                                    contributions,
                                                    scaleFactor),
                                                ContributionNumber(
                                                    ItemType.CHAPA,
                                                    contributions,
                                                    scaleFactor),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 894 * scaleFactor,
                                  height: 471 * scaleFactor,
                                  margin:
                                      EdgeInsets.only(top: 32 * scaleFactor),
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
                                        height: 42 * scaleFactor,
                                        color: Color(CommonColors.listHeader),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 32 * scaleFactor,
                                            right: 54 * scaleFactor,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Contribuição',
                                                textScaleFactor: scaleFactor,
                                                style: CommonText.itemSubtitle,
                                              ),
                                              Text(
                                                'Data',
                                                textScaleFactor: scaleFactor,
                                                style: CommonText.itemSubtitle,
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
                                            padding: EdgeInsets.only(
                                                top: 8 * scaleFactor),
                                            controller: _scrollController,
                                            itemCount: contributions.length,
                                            itemBuilder: (context, index) {
                                              return new ContributionItem(
                                                contribution:
                                                    contributions[index],
                                                author: user.name,
                                                index: index,
                                                canApprove: false,
                                                scaleFactor: scaleFactor,
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
                          left: 800 * scaleFactor,
                          top: 24 * scaleFactor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 48 * scaleFactor,
                                width: 48 * scaleFactor,
                                margin:
                                    EdgeInsets.only(bottom: 16 * scaleFactor),
                                child: Image.asset(
                                  "images/${_getUserRankMedal(userRanking)}.png",
                                  scale: 1 / scaleFactor,
                                ),
                              ),
                              Text(
                                '#${userRanking}',
                                textScaleFactor: scaleFactor,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CloseButtonWidget(
              onClick: onClose,
              scaleFactor: scaleFactor,
            ),
          ],
        ),
      ],
    );
  }
}

class ContributionNumber extends StatelessWidget {
  final ItemType type;
  final List<ContributionModel> contribs;
  double scaleFactor;

  ContributionNumber(this.type, this.contribs, this.scaleFactor);

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
          width: 32 * scaleFactor,
          height: 32 * scaleFactor,
          margin:
              EdgeInsets.only(right: 24 * scaleFactor, bottom: 8 * scaleFactor),
          child: SpriteWidget(
            sprite: Assets.ui
                .getSprite(type.toString().replaceAll('ItemType.', '')),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 24 * scaleFactor),
          child: Text(
            '${count}',
            textScaleFactor: scaleFactor,
            style: CommonText.heightOneShadow(14 * scaleFactor),
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
