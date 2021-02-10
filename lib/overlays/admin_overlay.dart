import 'dart:ui';

import 'package:dextraquario/assets.dart';
import 'package:dextraquario/common.dart';
import 'package:dextraquario/fish_info.dart';
import 'package:dextraquario/utils/scale_factor_calculator.dart';
import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flame/widgets/sprite_button.dart';
import 'package:flutter/material.dart';
import 'package:dextraquario/components/close_button_widget.dart';

import '../contribution.dart';

class AdminOverlay extends StatelessWidget {
  final Function onClose;
  final List<Contribution> _pendingItems = _mockItems();
  final ScrollController _scrollController = ScrollController();

  AdminOverlay({this.onClose});

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
                                          child: ListView.builder(
                                            controller: _scrollController,
                                            itemCount: _pendingItems.length,
                                            itemBuilder: (ctx, index) =>
                                                ContributionItem(
                                              contribution:
                                                  _pendingItems[index],
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
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CloseButtonWidget(onClick: onClose, scaleFactor: scaleFactor),
              ],
            ),
          ],
        ),
      );
    });
  }
}

List _mockItems() {
  return <Contribution>[
    Contribution(
      DateTime(2020, DateTime.september, 10),
      author: 'Erick Zanardo',
      type: ItemType.CONTRIBUICAO_COMUNIDADE,
      description:
          'Melhoria no Dextraquario para lidar com o gerenciamento de visibilidade da janela do browser',
      link: 'https://github.com/dextra/dextraquario/pull/54',
    ),
    Contribution(
      DateTime(2021, DateTime.january, 1),
      author: 'Tyemy Kuga',
      type: ItemType.CAFE_COM_CODIGO,
      description: 'This is a mockup description.',
      link: 'https://github.com/dextra/dextraquario/pull/yournumberhere',
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
