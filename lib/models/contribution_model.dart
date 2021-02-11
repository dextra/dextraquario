import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';

enum ItemType {
  DESAFIO_TECNICO,
  ENTREVISTA_PARTICIPACAO,
  ENTREVISTA_AVALIACAO_TESTE,
  CAFE_COM_CODIGO,
  CONTRIBUICAO_COMUNIDADE,
  ARTIGO_BLOG_DEXTRA,
  CHAPA
}

class ContributionModel {
  // constantes com os nomes dos documentos no banco de dados
  static const USER_ID = "user_id";
  static const DATE = "date";
  static const CATEGORY = "category";
  static const LINK = "contribution_link";
  static const DESCRIPTION = "description";
  static const APPROVAL = "approval";

  String _contributionid;
  String _userid;
  Timestamp _date;
  String _category;
  String _link;
  String _description;
  String _approval;

  //  getters
  String get contribution_id => _contributionid;
  String get user_id => _userid;
  DateTime get date => _date.toDate();
  ItemType get category => EnumToString.fromString(ItemType.values, _category);
  String get contribution_link => _link;
  String get description => _description;
  String get approval => _approval;

  // Get the title corresponding to the item type
  String getItemTitle() {
    switch (category) {
      case ItemType.DESAFIO_TECNICO:
        return 'Desafio técnico';
      case ItemType.ENTREVISTA_PARTICIPACAO:
        return 'Apoio técnico em entrevista';
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

  // GET
  ContributionModel.fromSnapshot(DocumentSnapshot snapshot) {
    _contributionid = snapshot.id;
    _userid = snapshot.data()[USER_ID];
    _date = snapshot.data()[DATE];
    _category = snapshot.data()[CATEGORY];
    _link = snapshot.data()[LINK];
    _description = snapshot.data()[DESCRIPTION];
    _approval = snapshot.data()[APPROVAL];
  }
}
