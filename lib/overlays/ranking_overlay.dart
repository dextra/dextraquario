import 'package:dextraquario/models/user_model.dart';
import 'package:dextraquario/services/user_service.dart';
import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flame/widgets/sprite_button.dart';
import 'package:flutter/material.dart';

import '../assets.dart';
import '../common.dart';

class RankingOverlay extends StatefulWidget {
  final Function onClose;

  RankingOverlay({this.onClose});

  @override
  _RankingOverlayState createState() => _RankingOverlayState();
}

class _RankingOverlayState extends State<RankingOverlay> {
  UserServices _userServices = UserServices();
  Future<List<UserModel>> _dbUsers;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _dbUsers = _userServices.getAll(); // get from DB
  }

  // User list
  Widget _userList(List<UserModel> users) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: users.length,
      itemBuilder: (ctx, index) => _buildItem(ctx, index, users),
    );
  }

  // Build user item
  Widget _buildItem(
      BuildContext buildContext, int index, List<UserModel> users) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _userItem(users[index], index),
        Divider(
          color: Colors.black26,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }

  // User item
  Widget _userItem(UserModel user, int index) {
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
                  onPressed: () => widget.onClose?.call(),
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
                                  // -- Para ser implementado na próxima task
                                  // Container(
                                  //   color: Colors.black.withOpacity(0.25),
                                  //   margin: EdgeInsets.symmetric(vertical: 8),
                                  //   child: _userItem(_users[14], 14),
                                  // ),
                                  Expanded(
                                    child: Scrollbar(
                                      isAlwaysShown: true,
                                      controller: _scrollController,
                                      child: FutureBuilder(
                                          // waiting for the _dbUsers data
                                          future: _dbUsers,
                                          builder: (context, snapshot) {
                                            // if the connection worked
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              // return the user list
                                              return _userList(snapshot.data);
                                            } else {
                                              // loading
                                              return Container(
                                                  padding:
                                                      EdgeInsets.only(top: 20),
                                                  child: Text('Loading...',
                                                      style: CommonText
                                                          .panelTitle));
                                            }
                                          }),
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
