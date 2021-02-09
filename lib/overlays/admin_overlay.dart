import 'dart:ui';

import 'package:dextraquario/assets.dart';
import 'package:dextraquario/common.dart';
import 'package:dextraquario/fish_info.dart';
import 'package:dextraquario/models/contribution_model.dart';
import 'package:dextraquario/services/contribution_service.dart';
import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flame/widgets/sprite_button.dart';
import 'package:flutter/material.dart';
import 'package:dextraquario/components/close_button_widget.dart';

import '../contribution.dart';

class AdminOverlay extends StatefulWidget {
  final Function onClose;
  // final List<Contribution> _pendingItems = _mockItems();

  AdminOverlay({this.onClose});

  @override
  _AdminOverlayState createState() => _AdminOverlayState();
}

class _AdminOverlayState extends State<AdminOverlay> {
  Future<List<ContributionModel>> _dbContributions;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // typeOfSorting = TypeOfSorting.SCORE_DESC;
    // _dbUsers = _userServices.getAll(); // get list of users from DB
    // _user = _userServices.getUserById(widget.userAuth.uid); // get user from DB
    _dbContributions = ContributionServices().getContributionsByApprovalStatus(ApprovalStatus.APPROVED);
  }

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
              CloseButtonWidget(onClick: widget.onClose),
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
                                          future: _dbContributions,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.done) {
                                              return ContributionList(pendingItems: snapshot.data, scrollController: _scrollController,);
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


  ContributionList({this.pendingItems, this.scrollController})

  @override
  Widget build(BuildContext context) {
    


    return pendingItems != null ? ListView.builder(
      controller: scrollController,
      itemCount: pendingItems.length,
      itemBuilder: (ctx, index) =>
          ContributionItem(
        contribution: pendingItems[index],
        index: index,
        canApprove: false,
      ),
    ) : Center();
  }
}

// List _mockItems() {
//   return <Contribution>[
//     Contribution(
//       DateTime(2020, DateTime.september, 10),
//       author: 'Erick Zanardo',
//       type: ItemType.CONTRIBUICAO_COMUNIDADE,
//       description:
//           'Melhoria no Dextraquario para lidar com o gerenciamento de visibilidade da janela do browser',
//       link: 'https://github.com/dextra/dextraquario/pull/54',
//     ),
//     Contribution(
//       DateTime(2021, DateTime.january, 1),
//       author: 'Tyemy Kuga',
//       type: ItemType.CAFE_COM_CODIGO,
//       description: 'This is a mockup description.',
//       link: 'https://github.com/dextra/dextraquario/pull/yournumberhere',
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
