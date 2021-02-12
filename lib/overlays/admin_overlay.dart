import 'dart:ui';
import 'package:dextraquario/assets.dart';
import 'package:dextraquario/common.dart';
import 'package:dextraquario/fish_info.dart';
import 'package:dextraquario/utils/scale_factor_calculator.dart';
import 'package:dextraquario/models/contribution_model.dart';
import 'package:dextraquario/models/user_model.dart';
import 'package:dextraquario/services/contribution_service.dart';
import 'package:dextraquario/services/user_service.dart';
import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flutter/material.dart';
import 'package:dextraquario/components/close_button_widget.dart';

class AdminOverlay extends StatefulWidget {
  final Function onClose;

  AdminOverlay({this.onClose});

  @override
  _AdminOverlayState createState() => _AdminOverlayState();
}

class _AdminOverlayState extends State<AdminOverlay> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double scaleFactor = ScaleFactorCalculator.calcScaleFactor(
          constraints.maxWidth, constraints.maxHeight);

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
                CloseButtonWidget(
                    onClick: () => widget.onClose?.call(),
                    scaleFactor: scaleFactor),
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Contribuições pendentes',
                                    textScaleFactor: scaleFactor,
                                    style: CommonText.panelTitle),
                                Container(
                                  width: 928 * scaleFactor,
                                  height: 624 * scaleFactor,
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
                                              right: 54 * scaleFactor),
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
                                          child: FutureBuilder(
                                            future: Future.wait(
                                              [
                                                UserServices().getAll(),
                                                ContributionServices()
                                                    .getContributionsByApprovalStatus(
                                                        ApprovalStatus
                                                            .ANALYZING)
                                              ],
                                            ),
                                            builder: (context,
                                                AsyncSnapshot<List<dynamic>>
                                                    snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                return ContributionList(
                                                  pendingItems:
                                                      snapshot.data[1],
                                                  authors: snapshot.data[0],
                                                  scrollController:
                                                      _scrollController,
                                                  updateList: () => setState(
                                                    () {},
                                                  ),
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
    });
  }
}

class ContributionList extends StatelessWidget {
  final List<ContributionModel> pendingItems;
  final ScrollController scrollController;
  final List<UserModel> authors;
  final Function updateList;

  ContributionList(
      {this.pendingItems,
      this.scrollController,
      this.authors,
      this.updateList});

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
              updateList: updateList,
            ),
          )
        : Center();
  }
}
