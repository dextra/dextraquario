import 'dart:ui';
import 'package:dextraquario/assets.dart';
import 'package:dextraquario/common.dart';
import 'package:dextraquario/models/contribution_model.dart';
import 'package:dextraquario/models/user_model.dart';
import 'package:dextraquario/services/contribution_service.dart';
import 'package:dextraquario/services/user_service.dart';
import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flutter/material.dart';
import 'package:dextraquario/components/close_button_widget.dart';

class AdminOverlay extends StatelessWidget {
  final Function onClose;
  final ScrollController _scrollController = ScrollController();
  final Future<List<ContributionModel>> _dbContributions =
      ContributionServices()
          .getContributionsByApprovalStatus(ApprovalStatus.ANALYZING);
  final Future<List<UserModel>> _dbUsers = UserServices().getAll();

  AdminOverlay({this.onClose});

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
              CloseButtonWidget(onClick: () => onClose?.call()),
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
                              Text('Contribuições pendentes',
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
                                        child: FutureBuilder(
                                          future: Future.wait(
                                            [
                                              _dbUsers,
                                              _dbContributions,
                                            ],
                                          ),
                                          builder: (context,
                                              AsyncSnapshot<List<dynamic>>
                                                  snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              return ContributionList(
                                                pendingItems: snapshot.data[1],
                                                authors: snapshot.data[0],
                                                scrollController:
                                                    _scrollController,
                                              );
                                            } else {
                                              // Loading screen
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Loading...',
                                                        style: CommonText
                                                            .panelTitle,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            }
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

class ContributionList extends StatelessWidget {
  final List<ContributionModel> pendingItems;
  final ScrollController scrollController;
  final List<UserModel> authors;

  ContributionList({this.pendingItems, this.scrollController, this.authors});

  @override
  Widget build(BuildContext context) {
    return pendingItems != null
        ? ListView.builder(
            controller: scrollController,
            itemCount: pendingItems.length,
            itemBuilder: (ctx, index) => ContributionItem(
              contribution: pendingItems[index],
              author: authors
                  .firstWhere(
                      (element) => element.id == pendingItems[index].user_id)
                  .name,
              index: index,
              canApprove: true,
            ),
          )
        : Center();
  }
}
