class FishInfo {
  String name;
  String fishColor;
  List<FishItem> fishItems;

  FishInfo({this.name, this.fishColor, this.fishItems});

  FishInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        fishColor = json['fishColor'],
        fishItems = json['items'].map((fishItem) => FishItem.fromJson(fishItem)).cast<FishItem>().toList();
}

class FishItem {
  ItemType name;
  String description;
  String link;

  FishItem({this.name, this.description, this.link});

  FishItem.fromJson(Map<String, dynamic> json)
      : name = ItemType.values.firstWhere((e) => e.toString() == 'ItemType.${json['name']}'),
        description = json['description'],
        link = json['link'];

  String getItemDescription() {
    String label;

    switch (name) {
      case ItemType.DESAFIO_TECNICO:
        label = 'Desafio Técnico';
        break;
      case ItemType.ENTREVISTA_PARTICIPACAO:
        label = 'Desafio Técnico';
        break;
      case ItemType.ENTREVISTA_AVALIACAO_TESTE:
        label = 'Desafio Técnico';
        break;
      case ItemType.CAFE_COM_CODIGO:
        label = 'Desafio Técnico';
        break;
      case ItemType.CONTRIBUICAO_COMUNIDADE:
        label = 'Desafio Técnico';
        break;
      case ItemType.ARTIGO_BLOG_DEXTRA:
        label = 'Desafio Técnico';
        break;
    }

    return label;
  }
}

enum ItemType {
  DESAFIO_TECNICO,
  ENTREVISTA_PARTICIPACAO,
  ENTREVISTA_AVALIACAO_TESTE,
  CAFE_COM_CODIGO,
  CONTRIBUICAO_COMUNIDADE,
  ARTIGO_BLOG_DEXTRA,
}
