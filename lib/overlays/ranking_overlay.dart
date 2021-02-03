import 'package:dextraquario/models/user_model.dart';
import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flame/widgets/sprite_button.dart';
import 'package:flutter/material.dart';

import '../assets.dart';

class RankingOverlay extends StatelessWidget {
  final Function onClose;
  final List<UserMockup> _users = _mockUsers();
  final ScrollController _scrollController = ScrollController();

  RankingOverlay({this.onClose});

  Widget _userItem(BuildContext buildContext, int index) {}

  @override
  Widget build(BuildContext context) {
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
                    width: 972,
                    height: 720,
                    padding: EdgeInsets.only(top: 32, left: 18, right: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Classificação', style: CommonText.panelTitle),
                            Container(
                              width: 928,
                              height: 624,
                              margin: EdgeInsets.only(top: 32),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Color(CommonColors.boxInsetBackground),
                                  ),
                                ],
                                border: _insetBorder(),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 42,
                                    color: Color(CommonColors.listHeader),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 32, right: 54),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Class.',
                                            style: CommonText.itemSubtitle,
                                          ),
                                          Text(
                                            'Nome',
                                            style: CommonText.itemSubtitle,
                                          ),
                                          Text(
                                            'Pontuação',
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
                                        controller: _scrollController,
                                        itemCount: _users.length,
                                        itemBuilder: (ctx, index) =>
                                            _userItem(ctx, index),
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

List _mockUsers() {
  return <UserMockup>[
    UserMockup(name: 'Erick Zanardo', score: 25),
    UserMockup(name: 'Marcio Souza', score: 20),
    UserMockup(name: 'Adriano Maringolo', score: 11),
    UserMockup(name: 'Fellipe Mendes', score: 10),
    UserMockup(name: 'Priscila Contiero', score: 10),
    UserMockup(name: 'Gustavo Bigardi', score: 8),
    UserMockup(name: 'Mauro Takeda', score: 7),
    UserMockup(name: 'Leonardo Bilia', score: 7),
    UserMockup(name: 'Tyemy Kuga', score: 6),
    UserMockup(name: 'Leonardo Paranhos', score: 6),
    UserMockup(name: 'Leandro Lima', score: 5),
    UserMockup(name: 'Leandro Lima', score: 5),
    UserMockup(name: 'Leandro Lima', score: 5),
    UserMockup(name: 'Leandro Lima', score: 5),
    UserMockup(name: 'Leandro Lima', score: 5),
    UserMockup(name: 'Mauro Takeda', score: 5),
  ];
}

class UserMockup {
  UserMockup({this.name, this.score});

  String name;
  int score;
}
