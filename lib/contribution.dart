/* Contribution class adapted from FishInfo/FishItem */
import 'package:dextraquario/models/contribution_model.dart';
import 'package:intl/intl.dart';

import 'package:dextraquario/models/contribution_model.dart';

import 'fish_info.dart';

class Contribution {
  String author;
  ItemType type;
  String date;
  String description;
  String link;
  final df = new DateFormat('dd/MM/yyyy');

  Contribution(DateTime dateTime,
      {this.author, this.type, this.description, this.link}) {
    this.date = df.format(dateTime);
  }

  String getItemDescription() {
    switch (type) {
      case ItemType.DESAFIO_TECNICO:
        return 'Desafio Técnico';
      case ItemType.ENTREVISTA_PARTICIPACAO:
        return 'Apoio técnico em Entrevista';
      case ItemType.ENTREVISTA_AVALIACAO_TESTE:
        return 'Avaliação de código de candidato';
      case ItemType.CAFE_COM_CODIGO:
        return 'Café com código';
      case ItemType.CONTRIBUICAO_COMUNIDADE:
        return 'Contribuição para comunidade';
      case ItemType.ARTIGO_BLOG_DEXTRA:
        return 'Artigo no blog da Dextra';
      case ItemType.CHAPA:
        return 'Chapa';
    }

    return '';
  }
}
