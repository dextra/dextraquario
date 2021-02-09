import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flame/widgets/sprite_button.dart';
import 'package:flutter/material.dart';

import '../assets.dart';
import '../common.dart';

class RankingOverlay extends StatelessWidget {
  final Function onClose;
  final List<UserMockup> _users = _mockUsers();
  final ScrollController _scrollController = ScrollController();

  RankingOverlay({this.onClose});

  Widget _buildItem(BuildContext buildContext, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _userItem(_users[index], index),
        Divider(
          color: Colors.black26,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }

  Widget _userItem(UserMockup user, int index) {
    return Padding(
      padding: EdgeInsets.only(
        left: 68,
        right: 54,
      ),
      child: ListTile(
        leading: Text(
          (index + 1).toString(),
          style: CommonText.itemTitle,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Photo container
            Padding(
              padding: EdgeInsets.only(left: 16, right: 20),
              child: Container(
                height: 32,
                width: 32,
                color: Colors.grey,
              ),
            ),
            Text(
              user.name,
              style: CommonText.itemTitle,
            ),
          ],
        ),
        trailing: Text(
          '${user.score.toString()}',
          style: CommonText.itemTitle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
                                border: Common.insetBorder,
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
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 527),
                                            child: Text(
                                              'Nome',
                                              style: CommonText.itemSubtitle,
                                            ),
                                          ),
                                          Text(
                                            'Pontuação',
                                            style: CommonText.itemSubtitle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.black.withOpacity(0.25),
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    child: _userItem(_users[14], 14),
                                  ),
                                  Expanded(
                                    child: Scrollbar(
                                      isAlwaysShown: true,
                                      controller: _scrollController,
                                      child: ListView.builder(
                                        controller: _scrollController,
                                        itemCount: _users.length,
                                        itemBuilder: (ctx, index) =>
                                            _buildItem(ctx, index),
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
    UserMockup(name: 'Leandro Lima', score: 4),
    UserMockup(name: 'Leandro Lima', score: 4),
    UserMockup(name: 'Vinícius Levorato', score: 2),
    UserMockup(name: 'Mauro Takeda', score: 1),
  ];
}

class UserMockup {
  UserMockup({this.name, this.score});

  String name;
  int score;
}
