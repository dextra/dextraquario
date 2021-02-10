import 'package:dextraquario/components/close_button_widget.dart';
import 'package:dextraquario/fish_info.dart';
import 'package:dextraquario/models/user_model.dart';
import 'package:dextraquario/services/user_service.dart';
import 'package:dextraquario/utils/scale_factor_calculator.dart';
import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flame/widgets/sprite_button.dart';
import 'package:flame/widgets/sprite_widget.dart';
import 'package:flutter/material.dart';

import '../assets.dart';
import '../common.dart';
import '../contribution.dart';

// ignore: must_be_immutable
class ProfileOverlay extends StatefulWidget {
  final Function onClose;
  String userID;

  ProfileOverlay({this.onClose, this.userID});

  @override
  State<StatefulWidget> createState() =>
      _ProfileOverlayState(onClose: this.onClose, userID: this.userID);
}

class _ProfileOverlayState extends State<ProfileOverlay> {
  final Function onClose;
  final String userID;

  _ProfileOverlayState({this.onClose, this.userID});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var scaleFactor = ScaleFactorCalculator.calcScaleFactor(
            constraints.maxWidth, constraints.maxHeight);
        return FutureBuilder(
          future: UserServices().getUserById(userID),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ProfileScreen(
                  onClose: this.onClose,
                  user: snapshot.data,
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
  final List<Contribution> _contributions = _mockItems();
  final ScrollController _scrollController = ScrollController();
  final UserModel user;
  double scaleFactor;

  ProfileScreen({this.onClose, this.user, this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    // User fetched ranking position
    int rank = 3;

    return Stack(
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
                                        color: Colors.grey,
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
                                                '${_contributions.length} contribuições',
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
                                                    _contributions,
                                                    scaleFactor),
                                                ContributionNumber(
                                                    ItemType.DESAFIO_TECNICO,
                                                    _contributions,
                                                    scaleFactor),
                                                ContributionNumber(
                                                    ItemType
                                                        .ENTREVISTA_PARTICIPACAO,
                                                    _contributions,
                                                    scaleFactor),
                                                ContributionNumber(
                                                    ItemType
                                                        .ENTREVISTA_AVALIACAO_TESTE,
                                                    _contributions,
                                                    scaleFactor),
                                                ContributionNumber(
                                                    ItemType.CAFE_COM_CODIGO,
                                                    _contributions,
                                                    scaleFactor),
                                                ContributionNumber(
                                                    ItemType.ARTIGO_BLOG_DEXTRA,
                                                    _contributions,
                                                    scaleFactor),
                                                ContributionNumber(
                                                    ItemType.CHAPA,
                                                    _contributions,
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
                                            itemCount: _contributions.length,
                                            itemBuilder: (ctx, index) =>
                                                ContributionItem(
                                              contribution:
                                                  _contributions[index],
                                              index: index,
                                              canApprove: false,
                                            ),
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
                                  "images/${_getUserRankMedal(rank)}.png",
                                  scale: 1 / scaleFactor,
                                ),
                              ),
                              Text(
                                '#${rank}',
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
      ],
    );
  }
}

class ContributionNumber extends StatelessWidget {
  final ItemType type;
  final List<Contribution> contribs;
  double scaleFactor;

  ContributionNumber(this.type, this.contribs, this.scaleFactor);

  @override
  Widget build(BuildContext context) {
    int count = 0;

    contribs.forEach((e) {
      e.type == type ? count += 1 : null;
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

List _mockItems() {
  return <Contribution>[
    Contribution(
      DateTime(2020, DateTime.september, 10),
      author: 'Vinicius Levorato',
      type: ItemType.CONTRIBUICAO_COMUNIDADE,
      description:
          'Melhoria no Dextraquario para lidar com o gerenciamento de visibilidade da janela do browser',
      link: 'https://github.com/dextra/dextraquario/pull/54',
    ),
    Contribution(
      DateTime(2021, DateTime.january, 1),
      author: 'Vinicius Levorato',
      type: ItemType.CAFE_COM_CODIGO,
      description: 'This is a mockup description.',
      link: 'https://github.com/dextra/dextraquario/pull/yournumberhere',
    ),
    Contribution(
      DateTime(2021, DateTime.january, 1),
      author: 'Vinicius Levorato',
      type: ItemType.ARTIGO_BLOG_DEXTRA,
      description:
          'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
      link: 'https://github.com/dextra/dextraquario/pull/35',
    ),
    Contribution(
      DateTime(2021, DateTime.january, 1),
      author: 'Vinicius Levorato',
      type: ItemType.CHAPA,
      description:
          'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
      link: 'https://github.com/dextra/dextraquario/pull/35',
    ),
    Contribution(
      DateTime(2021, DateTime.january, 1),
      author: 'Vinicius Levorato',
      type: ItemType.CONTRIBUICAO_COMUNIDADE,
      description:
          'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
      link: 'https://github.com/dextra/dextraquario/pull/35',
    ),
    Contribution(
      DateTime(2021, DateTime.january, 1),
      author: 'Vinicius Levorato',
      type: ItemType.CONTRIBUICAO_COMUNIDADE,
      description:
          'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
      link: 'https://github.com/dextra/dextraquario/pull/35',
    ),
    Contribution(
      DateTime(2021, DateTime.january, 1),
      author: 'Vinicius Levorato',
      type: ItemType.CONTRIBUICAO_COMUNIDADE,
      description:
          'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
      link: 'https://github.com/dextra/dextraquario/pull/35',
    ),
    Contribution(
      DateTime(2021, DateTime.january, 1),
      author: 'Vinicius Levorato',
      type: ItemType.CONTRIBUICAO_COMUNIDADE,
      description:
          'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
      link: 'https://github.com/dextra/dextraquario/pull/35',
    ),
    Contribution(
      DateTime(2021, DateTime.january, 1),
      author: 'Vinicius Levorato',
      type: ItemType.CONTRIBUICAO_COMUNIDADE,
      description:
          'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
      link: 'https://github.com/dextra/dextraquario/pull/35',
    ),
    Contribution(
      DateTime(2021, DateTime.january, 1),
      author: 'Vinicius Levorato',
      type: ItemType.CONTRIBUICAO_COMUNIDADE,
      description:
          'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
      link: 'https://github.com/dextra/dextraquario/pull/35',
    ),
  ];
}
