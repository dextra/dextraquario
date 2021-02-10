import 'dart:ui';

import 'package:dextraquario/components/close_button_widget.dart';
import 'package:dextraquario/models/user_model.dart';
import 'package:dextraquario/overlays/profile_overlay.dart';
import 'package:dextraquario/services/user_service.dart';
import 'package:dextraquario/utils/scale_factor_calculator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/widgets/nine_tile_box.dart';
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
  String _idToShow;
  bool _showProfile;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    typeOfSorting = TypeOfSorting.SCORE_DESC;
    _dbUsers = _userServices.getAll(); // get list of users from DB
    _user = _userServices.getUserById(widget.userAuth.uid); // get user from DB
    _showProfile = false;
    _idToShow = null;
  }

  void onTapUser(String id) {
    setState(() {
      _idToShow = id;
      _showProfile = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showProfile) {
      return ProfileOverlay(
        onClose: () {
          setState(() {
            _showProfile = false;
          });
        },
        userID: _idToShow,
      );
    } else {
      return LayoutBuilder(builder: (context, constraints) {
        double scaleFactor = ScaleFactorCalculator.calcScaleFactor(
            constraints.maxWidth, constraints.maxHeight);
        return Stack(
          children: [
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
                              destTileSize: 24 * scaleFactor,
                              width: 559 * scaleFactor,
                              height: 597 * scaleFactor,
                            ),
                            opacity: 0.5,
                          ),
                          padding: EdgeInsets.only(
                              top: 4.0 * scaleFactor, left: 2.0 * scaleFactor),
                        ),
                        ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                            child: NineTileBox(
                              image: Assets.panelImage,
                              tileSize: 12,
                              destTileSize: 36 * scaleFactor,
                              width: 972 * scaleFactor,
                              height: 720 * scaleFactor,
                              padding: EdgeInsets.only(
                                  top: 32 * scaleFactor,
                                  left: 18 * scaleFactor,
                                  right: 18 * scaleFactor),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('Classificação',
                                          textScaleFactor: scaleFactor,
                                          style: CommonText.panelTitle),
                                      Container(
                                        width: 928 * scaleFactor,
                                        height: 624 * scaleFactor,
                                        margin: EdgeInsets.only(
                                            top: 32 * scaleFactor),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(CommonColors
                                                  .boxInsetBackground),
                                            ),
                                          ],
                                          border: Common.insetBorder,
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 42 * scaleFactor,
                                              color: Color(
                                                  CommonColors.listHeader),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 32 * scaleFactor,
                                                    right: 54 * scaleFactor),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      child: Text(
                                                        'Class.',
                                                        textScaleFactor:
                                                            scaleFactor,
                                                        style: CommonText
                                                            .itemSubtitle,
                                                      ),
                                                      onTap: () {
                                                        changeTypeOfSortingScore();
                                                      },
                                                    ),
                                                    GestureDetector(
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                            right: 527 *
                                                                scaleFactor),
                                                        child: Text(
                                                          'Nome',
                                                          textScaleFactor:
                                                              scaleFactor,
                                                          style: CommonText
                                                              .itemSubtitle,
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        changeTypeOfSortingName();
                                                      },
                                                    ),
                                                    GestureDetector(
                                                      child: Text(
                                                        'Pontuação',
                                                        textScaleFactor:
                                                            scaleFactor,
                                                        style: CommonText
                                                            .itemSubtitle,
                                                      ),
                                                      onTap: () {
                                                        changeTypeOfSortingScore();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            FutureBuilder(
                                                future: Future.wait(
                                                    [_user, _dbUsers]),
                                                builder: (context,
                                                    AsyncSnapshot<List<dynamic>>
                                                        snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.done) {
                                                    // return the sorted user list
                                                    List<UserRanking>
                                                        userRanking =
                                                        orderUserList(
                                                            snapshot.data[1],
                                                            TypeOfSorting
                                                                .SCORE_DESC);
                                                    // get the current user
                                                    UserRanking currentUser =
                                                        getCurrentUser(
                                                            userRanking,
                                                            snapshot.data[0]);
                                                    return UserTopRanking(
                                                      user: currentUser,
                                                      scaleFactor: scaleFactor,
                                                    );
                                                  } else {
                                                    return LoadingUser(
                                                        scaleFactor:
                                                            scaleFactor);
                                                  }
                                                }),
                                            Expanded(
                                              child: Scrollbar(
                                                isAlwaysShown: true,
                                                controller: _scrollController,
                                                child: FutureBuilder(
                                                    // waiting for the _dbUsers data
                                                    future: _dbUsers,
                                                    builder:
                                                        (context, snapshot) {
                                                      // if the connection worked
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .done) {
                                                        // return the user list
                                                        List<UserRanking>
                                                            userRanking =
                                                            orderUserList(
                                                                snapshot.data,
                                                                typeOfSorting);
                                                        return UserList(
                                                          onTapUser: onTapUser,
                                                          users: userRanking,
                                                          scrollController:
                                                              _scrollController,
                                                          scaleFactor:
                                                              scaleFactor,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CloseButtonWidget(
                    onClick: widget.onClose, scaleFactor: scaleFactor),
              ],
            ),
          ],
        );
      });
    }
  }

  // Change the type of sorting SCORE (asc <--> desc)
  void changeTypeOfSortingScore() {
    setState(
      () {
        // if type is
        switch (typeOfSorting) {
          // score desc -> change to score asc
          case TypeOfSorting.SCORE_DESC:
            {
              typeOfSorting = TypeOfSorting.SCORE_ASC;
            }
            break;
          // score asc -> change to score desc
          default:
            {
              typeOfSorting = TypeOfSorting.SCORE_DESC;
            }
            break;
        }
      },
    );
  }

  // Change the type of sorting NAME (asc <--> desc)
  void changeTypeOfSortingName() {
    setState(
      () {
        // if type is
        switch (typeOfSorting) {
          // name asc -> change to name desc
          case TypeOfSorting.NAME_ASC:
            {
              typeOfSorting = TypeOfSorting.NAME_DESC;
            }
            break;
          // name desc -> change to name asc
          default:
            {
              typeOfSorting = TypeOfSorting.NAME_ASC;
            }
            break;
        }
      },
    );
  }
}

// Loading screen
class LoadingUser extends StatelessWidget {
  final double scaleFactor;

  LoadingUser({this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20 * scaleFactor),
      child: Text(
        'Loading...',
        textScaleFactor: scaleFactor,
        style: CommonText.panelTitle,
      ),
    );
  }
}

// User's own ID in the 1st place of the ranking
class UserTopRanking extends StatelessWidget {
  final UserRanking user;
  final double scaleFactor;

  UserTopRanking({this.user, this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.25),
      margin: EdgeInsets.symmetric(vertical: 8 * scaleFactor),
      child: UserItem(
        user: user,
        scaleFactor: scaleFactor,
      ),
    );
  }
}

// The list of users
class UserList extends StatelessWidget {
  final List<UserRanking> users;
  final ScrollController scrollController;
  final Function onTapUser;
  final double scaleFactor;

  UserList(
      {this.users, this.scrollController, this.onTapUser, this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: users.length,
      itemBuilder: (ctx, index) => BuildItem(
        index: index,
        users: users,
        onTapUser: onTapUser,
        scaleFactor: scaleFactor,
      ),
    );
  }
}

class BuildItem extends StatelessWidget {
  final int index;
  final List<UserRanking> users;
  final Function onTapUser;
  final double scaleFactor;

  BuildItem({this.index, this.users, this.onTapUser, this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: UserItem(
            user: users[index],
            scaleFactor: scaleFactor,
          ),
          onTap: () => onTapUser?.call(users[index].id),
        ),
        Divider(
          color: Colors.black26,
          height: 16 * scaleFactor,
          indent: 20 * scaleFactor,
          endIndent: 20 * scaleFactor,
        ),
      ],
    );
  }
}

// Each user item in the list
class UserItem extends StatelessWidget {
  final UserRanking user;
  final scaleFactor;

  UserItem({this.user, this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 68 * scaleFactor,
        right: 54 * scaleFactor,
      ),
      child: ListTile(
        leading: Text(
          (user.rank + 1).toString(),
          textScaleFactor: scaleFactor,
          style: CommonText.itemTitle,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Photo container
            Padding(
              padding: EdgeInsets.only(
                  left: 16 * scaleFactor, right: 20 * scaleFactor),
              child: Container(
                height: 32 * scaleFactor,
                width: 32 * scaleFactor,
                color: Colors.grey,
              ),
            ),
            Text(
              user.name,
              textScaleFactor: scaleFactor,
              style: CommonText.itemTitle,
            ),
          ],
        ),
        trailing: Text(
          '${user.score.toString()}',
          textScaleFactor: scaleFactor,
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
