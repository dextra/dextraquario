import 'package:dextraquario/fish_info.dart';
import 'package:dextraquario/models/contribution_model.dart';
import 'package:dextraquario/models/user_model.dart';
import 'package:dextraquario/services/contribution_service.dart';
import 'package:dextraquario/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flame/widgets/sprite_button.dart';
import 'package:flame/widgets/sprite_widget.dart';
import 'package:flutter/material.dart';

import '../assets.dart';
import '../common.dart';
import '../contribution.dart';

class ProfileOverlay extends StatefulWidget {
  final Function onClose;
  final User userAuth;

  ProfileOverlay({this.onClose, this.userAuth});

  @override
  State<StatefulWidget> createState() =>
      _ProfileOverlayState(onClose: this.onClose, userAuth: this.userAuth);
}

class _ProfileOverlayState extends State<ProfileOverlay> {
  final Function onClose;
  final User userAuth;
  Future<UserModel> _user;
  Future<List<ContributionModel>> _contributions;

  _ProfileOverlayState({this.onClose, this.userAuth});

  @override
  void initState() {
    _contributions = ContributionServices().getContributionByUser(userAuth.uid);
    _user = UserServices().getUserById(userAuth.uid);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([_user, _contributions]),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          print('snapshot ${snapshot.data[0]}');
          return ProfileScreen(
            onClose: this.onClose,
            listContributions: snapshot.data[1],
            user: snapshot.data[0],
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
  final List<ContributionModel> listContributions;
  final UserModel user;
  List<Contribution> _contributions;
  Future _doneFuture;

  ProfileScreen({this.onClose, this.listContributions, this.user});

  Future get initializationDone => _doneFuture;

  @override
  Widget build(BuildContext context) {
    // User fetched ranking position
    int rank = 3;
    int numberOfContribs = _contributions != null ? _contributions.length : 0;

    return Stack(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Padding(
            padding: EdgeInsets.only(top: 44, right: 44),
            child: SpriteButton(
                onPressed: () => onClose?.call(),
                label: null,
                width: 48,
                height: 48,
                sprite: Assets.closeButton48,
                pressedSprite: Assets.closeButton48),
          ),
        ]),
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
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Photo container
                                      Container(
                                        width: 126,
                                        height: 126,
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
                                              style: CommonText.heightOneShadow(
                                                  20),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                top: 8,
                                                bottom: 20,
                                              ),
                                              child: Text(
                                                '${numberOfContribs} contribuições',
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
                                                  listContributions,
                                                ),
                                                ContributionNumber(
                                                  ItemType.DESAFIO_TECNICO,
                                                  listContributions,
                                                ),
                                                ContributionNumber(
                                                  ItemType
                                                      .ENTREVISTA_PARTICIPACAO,
                                                  listContributions,
                                                ),
                                                ContributionNumber(
                                                  ItemType
                                                      .ENTREVISTA_AVALIACAO_TESTE,
                                                  listContributions,
                                                ),
                                                ContributionNumber(
                                                  ItemType.CAFE_COM_CODIGO,
                                                  listContributions,
                                                ),
                                                ContributionNumber(
                                                  ItemType.ARTIGO_BLOG_DEXTRA,
                                                  listContributions,
                                                ),
                                                ContributionNumber(
                                                  ItemType.CHAPA,
                                                  listContributions,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Contribuição',
                                                style: CommonText.itemSubtitle,
                                              ),
                                              Text(
                                                'Data',
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
                                          child: _contributions != null
                                              ? ListView.builder(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                  controller: _scrollController,
                                                  itemCount: 1,
                                                  itemBuilder: (ctx, index) =>
                                                      ContributionItem(
                                                    contribution:
                                                        _contributions[index],
                                                    index: index,
                                                    canApprove: false,
                                                  ),
                                                )
                                              : Center(),
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
                                  "images/${_getUserRankMedal(rank)}.png",
                                ),
                              ),
                              Text(
                                '#${rank}',
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

  ContributionNumber(this.type, this.contribs);

  @override
  Widget build(BuildContext context) {
    int count = 0;

    if (contribs != null) {
      contribs.forEach((e) {
        e.type == type ? count += 1 : null;
      });
    }

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

// List _mockItems() {
//   return <Contribution>[
//     Contribution(
//       DateTime(2020, DateTime.september, 10),
//       author: 'Vinicius Levorato',
//       type: ItemType.CONTRIBUICAO_COMUNIDADE,
//       description:
//           'Melhoria no Dextraquario para lidar com o gerenciamento de visibilidade da janela do browser',
//       link: 'https://github.com/dextra/dextraquario/pull/54',
//     ),
//     Contribution(
//       DateTime(2021, DateTime.january, 1),
//       author: 'Vinicius Levorato',
//       type: ItemType.CAFE_COM_CODIGO,
//       description: 'This is a mockup description.',
//       link: 'https://github.com/dextra/dextraquario/pull/yournumberhere',
//     ),
//     Contribution(
//       DateTime(2021, DateTime.january, 1),
//       author: 'Vinicius Levorato',
//       type: ItemType.ARTIGO_BLOG_DEXTRA,
//       description:
//           'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
//       link: 'https://github.com/dextra/dextraquario/pull/35',
//     ),
//     Contribution(
//       DateTime(2021, DateTime.january, 1),
//       author: 'Vinicius Levorato',
//       type: ItemType.CHAPA,
//       description:
//           'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
//       link: 'https://github.com/dextra/dextraquario/pull/35',
//     ),
//     Contribution(
//       DateTime(2021, DateTime.january, 1),
//       author: 'Vinicius Levorato',
//       type: ItemType.CONTRIBUICAO_COMUNIDADE,
//       description:
//           'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
//       link: 'https://github.com/dextra/dextraquario/pull/35',
//     ),
//     Contribution(
//       DateTime(2021, DateTime.january, 1),
//       author: 'Vinicius Levorato',
//       type: ItemType.CONTRIBUICAO_COMUNIDADE,
//       description:
//           'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
//       link: 'https://github.com/dextra/dextraquario/pull/35',
//     ),
//     Contribution(
//       DateTime(2021, DateTime.january, 1),
//       author: 'Vinicius Levorato',
//       type: ItemType.CONTRIBUICAO_COMUNIDADE,
//       description:
//           'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
//       link: 'https://github.com/dextra/dextraquario/pull/35',
//     ),
//     Contribution(
//       DateTime(2021, DateTime.january, 1),
//       author: 'Vinicius Levorato',
//       type: ItemType.CONTRIBUICAO_COMUNIDADE,
//       description:
//           'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
//       link: 'https://github.com/dextra/dextraquario/pull/35',
//     ),
//     Contribution(
//       DateTime(2021, DateTime.january, 1),
//       author: 'Vinicius Levorato',
//       type: ItemType.CONTRIBUICAO_COMUNIDADE,
//       description:
//           'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
//       link: 'https://github.com/dextra/dextraquario/pull/35',
//     ),
//     Contribution(
//       DateTime(2021, DateTime.january, 1),
//       author: 'Vinicius Levorato',
//       type: ItemType.CONTRIBUICAO_COMUNIDADE,
//       description:
//           'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
//       link: 'https://github.com/dextra/dextraquario/pull/35',
//     ),
//   ];
// }
