import 'package:dextraquario/assets.dart';
import 'package:dextraquario/fish_info.dart';
import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flame/widgets/sprite_button.dart';
import 'package:flame/widgets/sprite_widget.dart';
import 'package:flutter/material.dart';

class AdminOverlay extends StatelessWidget {
  final Function onClose;
  final List<Contribution> _pendingItems = _mockItems();
  final ScrollController _scrollController = ScrollController();

  AdminOverlay({this.onClose});

  Widget _contributionItem(BuildContext context, int index) {
    //final format = new DateFormat('dd/MM/yyyy'); // needs intl package addition

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ExpansionTile(
          leading: Container(
            width: 64,
            height: 64,
            child: SpriteWidget(
                sprite: Assets.ui.getSprite(
              _pendingItems[index].type.toString().replaceAll('ItemType.', ''),
            )),
          ),
          trailing: Text(
            _pendingItems[index]
                .date
                .toString()
                .replaceAll(RegExp('[0-9]+:[0-9]+:[0-9]+.[0-9]+'),
                    '') // this should be removed if using intl package
                .trimRight(),
            style: TextStyle(color: Colors.white),
          ),
          title: Text(
            _pendingItems[index].getItemDescription(),
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            _pendingItems[index].author,
            style: TextStyle(color: Colors.white),
          ),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 92, right: 64, bottom: 16),
                    child: Row(children: [
                      Expanded(
                          child: Text(
                        _pendingItems[index].description +
                            "\n\n" +
                            _pendingItems[index].link,
                        style: TextStyle(
                            color: Colors.white,
                            textBaseline: TextBaseline.alphabetic),
                      ))
                    ])),
                Padding(
                    padding: EdgeInsets.only(right: 48, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: SpriteButton(
                                width: 32,
                                height: 32,
                                onPressed: null,
                                label: null,
                                sprite: Assets.closeButton32,
                                pressedSprite: Assets.closeButton32)),
                        SpriteButton(
                            width: 32,
                            height: 32,
                            onPressed: null,
                            label: null,
                            sprite: Assets.closeButton32,
                            pressedSprite: Assets.closeButton32)
                      ],
                    ))
              ],
            )
          ],
        ),
        Divider(
          color: Colors.black26,
          indent: 20,
          endIndent: 20,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 44),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NineTileBox(
              image: Assets.panelImage,
              tileSize: 12,
              destTileSize: 36,
              width: 972,
              height: 720,
              padding: EdgeInsets.symmetric(vertical: 36),
              child: Container(
                padding: EdgeInsets.only(bottom: 36),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Contribuições pendentes',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Expanded(
                            child: Container(
                          width: 928,
                          height: 624,
                          margin: EdgeInsets.only(top: 32),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: Color(0xFFC06C4C)),
                            ],
                            border: _insetBorder(),
                          ),
                          child: Scrollbar(
                            isAlwaysShown: true,
                            controller: _scrollController,
                            child: ListView.builder(
                                itemCount: _pendingItems.length,
                                itemBuilder: (ctx, index) =>
                                    _contributionItem(ctx, index)),
                          ),
                        )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/* Contribution class adapted from FishInfo/FishItem */
class Contribution {
  String author;
  ItemType type;
  DateTime date;
  String description;
  String link;

  Contribution(
      {this.author, this.type, this.description, this.link, this.date});

  String getItemDescription() {
    String label;

    switch (type) {
      case ItemType.DESAFIO_TECNICO:
        label = 'Desafio Técnico';
        break;
      case ItemType.ENTREVISTA_PARTICIPACAO:
        label = 'Apoio técnico em Entrevista';
        break;
      case ItemType.ENTREVISTA_AVALIACAO_TESTE:
        label = 'Avaliação de código de candidato';
        break;
      case ItemType.CAFE_COM_CODIGO:
        label = 'Café com código';
        break;
      case ItemType.CONTRIBUICAO_COMUNIDADE:
        label = 'Contribuição para comunidade';
        break;
      case ItemType.ARTIGO_BLOG_DEXTRA:
        label = 'Artigo no blog da Dextra';
        break;
      case ItemType.CHAPA:
        label = 'Chapa';
        break;
    }

    return label;
  }
}

Border _insetBorder() {
  return Border(
      right: BorderSide(color: Color(0x5FEFCBBA), width: 4.0),
      bottom: BorderSide(color: Color(0x5FEFCBBA), width: 4.0),
      left: BorderSide(color: Color(0x5A000000), width: 4.0),
      top: BorderSide(color: Color(0x5A000000), width: 4.0));
}

List _mockItems() {
  return <Contribution>[
    Contribution(
      author: 'Erick Zanardo',
      type: ItemType.CONTRIBUICAO_COMUNIDADE,
      description:
          'Melhoria no Dextraquario para lidar com o gerenciamento de visibilidade da janela do browser',
      link: 'https://github.com/dextra/dextraquario/pull/54',
      date: DateTime(2020, DateTime.september, 10),
    ),
    Contribution(
      author: 'Tyemy Kuga',
      type: ItemType.CAFE_COM_CODIGO,
      description: 'This is a mockup description.',
      link: 'https://github.com/dextra/dextraquario/pull/yournumberhere',
      date: DateTime(2021, DateTime.january, 1),
    ),
    Contribution(
      author: 'Vinicius Levorato',
      type: ItemType.CONTRIBUICAO_COMUNIDADE,
      description:
          'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
      link: 'https://github.com/dextra/dextraquario/pull/35',
      date: DateTime(2021, DateTime.january, 1),
    ),
    Contribution(
      author: 'Vinicius Levorato',
      type: ItemType.CONTRIBUICAO_COMUNIDADE,
      description:
          'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
      link: 'https://github.com/dextra/dextraquario/pull/35',
      date: DateTime(2021, DateTime.january, 1),
    ),
    Contribution(
      author: 'Vinicius Levorato',
      type: ItemType.CONTRIBUICAO_COMUNIDADE,
      description:
          'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
      link: 'https://github.com/dextra/dextraquario/pull/35',
      date: DateTime(2021, DateTime.january, 1),
    ),
    Contribution(
      author: 'Vinicius Levorato',
      type: ItemType.CONTRIBUICAO_COMUNIDADE,
      description:
          'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
      link: 'https://github.com/dextra/dextraquario/pull/35',
      date: DateTime(2021, DateTime.january, 1),
    ),
    Contribution(
      author: 'Vinicius Levorato',
      type: ItemType.CONTRIBUICAO_COMUNIDADE,
      description:
          'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
      link: 'https://github.com/dextra/dextraquario/pull/35',
      date: DateTime(2021, DateTime.january, 1),
    ),
    Contribution(
      author: 'Vinicius Levorato',
      type: ItemType.CONTRIBUICAO_COMUNIDADE,
      description:
          'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
      link: 'https://github.com/dextra/dextraquario/pull/35',
      date: DateTime(2021, DateTime.january, 1),
    ),
    Contribution(
      author: 'Vinicius Levorato',
      type: ItemType.CONTRIBUICAO_COMUNIDADE,
      description:
          'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
      link: 'https://github.com/dextra/dextraquario/pull/35',
      date: DateTime(2021, DateTime.january, 1),
    ),
    Contribution(
      author: 'Vinicius Levorato',
      type: ItemType.CONTRIBUICAO_COMUNIDADE,
      description:
          'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
      link: 'https://github.com/dextra/dextraquario/pull/35',
      date: DateTime(2021, DateTime.january, 1),
    ),
    Contribution(
      author: 'Vinicius Levorato',
      type: ItemType.CONTRIBUICAO_COMUNIDADE,
      description:
          'Criação de efeito RGB shift para simular o efeito de televisões antigas de tubo em jogo open source.',
      link: 'https://github.com/dextra/dextraquario/pull/35',
      date: DateTime(2021, DateTime.january, 1),
    ),
  ];
}
