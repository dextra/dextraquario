class FishInfo {
  String name;
  String fishColor;
  int ranking;
  List<FishItem> fishItems;

  FishInfo({this.name, this.fishColor, this.fishItems});

  FishInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        fishColor = json['fishColor'],
        ranking = json['ranking'],
        fishItems = json['items']
            .map((fishItem) => FishItem.fromJson(fishItem))
            .cast<FishItem>()
            .toList();

  Map<String, dynamic> toJson() => {
        'name': name,
        'fishColor': fishColor,
        'ranking': ranking,
        'items': fishItems.map((item) => item.toJson()).toList()
      };
}

class FishItem {
  ItemType name;
  String description;
  String link;

  FishItem({this.name, this.description, this.link});

  FishItem.fromJson(Map<String, dynamic> json)
      : name = ItemType.values
            .firstWhere((e) => e.toString() == 'ItemType.${json['name']}'),
        description = json['description'],
        link = json['link'];

  Map<String, dynamic> toJson() => {
        'name': name.toString().replaceAll('ItemType.', ''),
        'description': description,
        'link': link
      };

  String getItemDescription() {
    String label;

    switch (name) {
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

enum ItemType {
  DESAFIO_TECNICO,
  ENTREVISTA_PARTICIPACAO,
  ENTREVISTA_AVALIACAO_TESTE,
  CAFE_COM_CODIGO,
  CONTRIBUICAO_COMUNIDADE,
  ARTIGO_BLOG_DEXTRA,
  CHAPA
}
