import 'dart:ui';

import 'package:dextraquario/models/user_model.dart';
import 'package:dextraquario/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flame/widgets/sprite_button.dart';
import 'package:flutter/material.dart';

import '../assets.dart';
import '../common.dart';

enum TypeOfSorting { SCORE_DESC, SCORE_ASC, NAME_DESC, NAME_ASC }
// the default is SCORE_DESC (sorting by descending score)

class RankingOverlay extends StatefulWidget {
  final Function onClose;
  final User userAuth;

  RankingOverlay({this.onClose, this.userAuth});

  @override
  _RankingOverlayState createState() => _RankingOverlayState();
}

class _RankingOverlayState extends State<RankingOverlay> {
  UserServices _userServices = UserServices();
  Future<List<UserModel>> _dbUsers;
  Future<UserModel> _user;
  TypeOfSorting typeOfSorting;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    typeOfSorting = TypeOfSorting.SCORE_DESC;
    _dbUsers = _userServices.getAll(); // get list of users from DB
    _user = _userServices.getUserById(widget.userAuth.uid); // get user from DB
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
                Stack(
                  children: [
                    Container(
                      child: Opacity(
                        child: NineTileBox(
                          image: Assets.panelShadow,
                          tileSize: 12,
                          destTileSize: 24,
                          width: 559,
                          height: 597,
                        ),
                        opacity: 0.5,
                      ),
                      padding: EdgeInsets.only(top: 4.0, left: 2.0),
                    ),
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                        child: NineTileBox(
                          image: Assets.panelImage,
                          tileSize: 12,
                          destTileSize: 36,
                          width: 972,
                          height: 720,
                          padding:
                              EdgeInsets.only(top: 32, left: 18, right: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Classificação',
                                      style: CommonText.panelTitle),
                                  Container(
                                    width: 928,
                                    height: 624,
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
                                                left: 32, right: 54),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  child: Text(
                                                    'Class.',
                                                    style:
                                                        CommonText.itemSubtitle,
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      changeTypeOfSorting();
                                                    });
                                                  },
                                                ),
                                                GestureDetector(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 527),
                                                    child: Text(
                                                      'Nome',
                                                      style: CommonText
                                                          .itemSubtitle,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      changeTypeOfSorting();
                                                    });
                                                  },
                                                ),
                                                GestureDetector(
                                                  child: Text(
                                                    'Pontuação',
                                                    style:
                                                        CommonText.itemSubtitle,
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      changeTypeOfSorting();
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        FutureBuilder(
                                            future:
                                                Future.wait([_user, _dbUsers]),
                                            builder: (context,
                                                AsyncSnapshot<List<dynamic>>
                                                    snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                // return the sorted user list
                                                List<UserRanking> userRanking =
                                                    orderUserList(
                                                        snapshot.data[1],
                                                        TypeOfSorting
                                                            .SCORE_DESC);
                                                // get the current user
                                                UserRanking currentUser =
                                                    getCurrentUser(userRanking,
                                                        snapshot.data[0]);
                                                return UserTopRanking(
                                                  user: currentUser,
                                                );
                                              } else {
                                                return LoadingUser();
                                              }
                                            }),
                                        Expanded(
                                          child: Scrollbar(
                                            isAlwaysShown: true,
                                            controller: _scrollController,
                                            child: FutureBuilder(
                                                // waiting for the _dbUsers data
                                                future: _dbUsers,
                                                builder: (context, snapshot) {
                                                  // if the connection worked
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.done) {
                                                    // return the user list
                                                    List<UserRanking>
                                                        userRanking =
                                                        orderUserList(
                                                            snapshot.data,
                                                            typeOfSorting);
                                                    return UserList(
                                                      users: userRanking,
                                                      scrollController:
                                                          _scrollController,
                                                    );
                                                  } else {
                                                    // loading
                                                    return Container();
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
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Change the type of sorting (asc <--> desc)
  void changeTypeOfSorting() {
    // if type is
    switch (typeOfSorting) {
      // score desc -> change to score asc
      case TypeOfSorting.SCORE_DESC:
        {
          typeOfSorting = TypeOfSorting.SCORE_ASC;
        }
        break;
      // score asc -> change to score desc
      case TypeOfSorting.SCORE_ASC:
        {
          typeOfSorting = TypeOfSorting.SCORE_DESC;
        }
        break;
      // name desc -> change to name asc
      case TypeOfSorting.NAME_DESC:
        {
          typeOfSorting = TypeOfSorting.NAME_ASC;
        }
        break;
      // name asc -> change to name desc
      case TypeOfSorting.NAME_ASC:
        {
          typeOfSorting = TypeOfSorting.NAME_DESC;
        }
        break;
    }
  }
}

// Loading screen
class LoadingUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20),
        child: Text('Loading...', style: CommonText.panelTitle));
  }
}

// User's own ID in the 1st place of the ranking
class UserTopRanking extends StatelessWidget {
  final UserRanking user;
  UserTopRanking({this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.25),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: UserItem(user: user),
    );
  }
}

// The list of users
class UserList extends StatelessWidget {
  final List<UserRanking> users;
  final ScrollController scrollController;

  UserList({this.users, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: users.length,
      itemBuilder: (ctx, index) => BuildItem(index: index, users: users),
    );
  }

  /* Widget _buildItem(
      BuildContext buildContext, int index, List<UserRanking> users) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UserItem(user: users[index]),
        Divider(
          color: Colors.black26,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  } */
}

class BuildItem extends StatelessWidget {
  final int index;
  final List<UserRanking> users;

  BuildItem({this.index, this.users});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UserItem(user: users[index]),
        Divider(
          color: Colors.black26,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}

// Each user item in the list
class UserItem extends StatelessWidget {
  final UserRanking user;
  UserItem({this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 68,
        right: 54,
      ),
      child: ListTile(
        leading: Text(
          (user.rank + 1).toString(),
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
}

// List of user ranking
class UserRanking {
  String id;
  String name;
  int score;
  int rank;

  UserRanking({this.id, this.name, this.rank, this.score});
}

// Sorting the users list
List<UserRanking> orderUserList(List<UserModel> userList, TypeOfSorting type) {
  List<UserRanking> userRanking = [];
  // first ordenation by score descending with name as tiebreaker
  userList.sort((a, b) => a.name.compareTo(b.name));
  userList.sort((a, b) => b.score.compareTo(a.score));

  // create user ranking by the ordenation
  userList.asMap().forEach((index, value) {
    userRanking.add(UserRanking(
        id: value.id, name: value.name, score: value.score, rank: index));
  });

  // if it's ordered by score ascending (rank descending) sort again
  if (type == TypeOfSorting.SCORE_ASC) {
    userRanking.sort((a, b) => b.rank.compareTo(a.rank));
  }
  // if it's ordered by name ascending, sort again
  else if (type == TypeOfSorting.NAME_ASC) {
    userRanking.sort((a, b) => a.name.compareTo(b.name));
  }
  // if it's ordered by name descending, sort again
  else if (type == TypeOfSorting.NAME_DESC) {
    userRanking.sort((a, b) => b.name.compareTo(a.name));
  }

  return userRanking;
}

// Get the current user in the user ranking list
UserRanking getCurrentUser(List<UserRanking> userList, UserModel user) {
  return userList.firstWhere((element) => element.id == user.id);
}
