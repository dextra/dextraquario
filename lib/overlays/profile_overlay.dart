import 'package:dextraquario/fish_info.dart';
import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flame/widgets/sprite_button.dart';
import 'package:flame/widgets/sprite_widget.dart';
import 'package:flutter/material.dart';

import '../assets.dart';
import '../common.dart';
import '../contribution.dart';

class ProfileOverlay extends StatelessWidget {
  final Function onClose;
  final List<Contribution> _contributions = _mockItems();
  final ScrollController _scrollController = ScrollController();

  ProfileOverlay({this.onClose});

  Widget _contributionNumber(ItemType type) {
    int count = 0;

    _contributions.forEach((e) {
      e.type == type ? count += 1 : null;
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 32,
          height: 32,
          padding: EdgeInsets.only(right: 8),
          child: SpriteWidget(
            sprite: Assets.ui
                .getSprite(type.toString().replaceAll('ItemType.', '')),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: Text(
            '${count}',
            style: CommonText.heightOneShadow(14),
          ),
        ),
      ],
    );
  }

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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Photo container
                                  Container(
                                    width: 126,
                                    height: 126,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 40),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Vinícius Levorato',
                                          style: CommonText.heightOneShadow(20),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 8,
                                            bottom: 20,
                                          ),
                                          child: Text(
                                            '${_contributions.length} contribuições',
                                            style: CommonText.itemTitle,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            _contributionNumber(ItemType
                                                .CONTRIBUICAO_COMUNIDADE),
                                            _contributionNumber(
                                                ItemType.DESAFIO_TECNICO),
                                            _contributionNumber(ItemType
                                                .ENTREVISTA_PARTICIPACAO),
                                            _contributionNumber(ItemType
                                                .ENTREVISTA_AVALIACAO_TESTE),
                                            _contributionNumber(
                                                ItemType.CAFE_COM_CODIGO),
                                            _contributionNumber(
                                                ItemType.ARTIGO_BLOG_DEXTRA),
                                            _contributionNumber(ItemType.CHAPA),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 263),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 48,
                                          width: 48,
                                          margin: EdgeInsets.only(bottom: 16),
                                          child: Image.asset(
                                            "images/profileMedal.png",
                                          ),
                                        ),
                                        Text(
                                          '#15',
                                          style: CommonText.heightOneShadow(18),
                                        ),
                                      ],
                                    ),
                                  )
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
                                      child: ListView.builder(
                                        padding: EdgeInsets.only(top: 8),
                                        controller: _scrollController,
                                        itemCount: _contributions.length,
                                        itemBuilder: (ctx, index) =>
                                            Common.contributionItem(
                                                _contributions[index], index,
                                                canApprove: false),
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

List _mockItems() {
  return <Contribution>[
    Contribution(
      DateTime(2020, DateTime.september, 10),
      author: 'Vinicius Levorato',
      type: ItemType.CONTRIBUICAO_COMUNIDADE,
      description:
          'Melhoria no Dextraquario para lidar com o gerenciamento de visibilidade da janela do browser',
      link: 'https://github.com/dextra/dextraquario/pull/54',
    ),
    Contribution(
      DateTime(2021, DateTime.january, 1),
      author: 'Vinicius Levorato',
      type: ItemType.CAFE_COM_CODIGO,
      description: 'This is a mockup description.',
      link: 'https://github.com/dextra/dextraquario/pull/yournumberhere',
    ),
    Contribution(
      DateTime(2021, DateTime.january, 1),
      author: 'Vinicius Levorato',
      type: ItemType.ARTIGO_BLOG_DEXTRA,
      description:
          'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
      link: 'https://github.com/dextra/dextraquario/pull/35',
    ),
    Contribution(
      DateTime(2021, DateTime.january, 1),
      author: 'Vinicius Levorato',
      type: ItemType.CHAPA,
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
