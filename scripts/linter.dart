import 'dart:io';
import 'dart:convert';
import '../lib/fish_info.dart';

void main() {
  final contributions = Directory('contributions');

  contributions.listSync(recursive: false, followLinks: false).forEach((element) {
    final userDir = Directory(element.path);

    userDir.listSync(recursive: false, followLinks: false).forEach((element) {
      print(element.path);

      final fileRaw = File(element.path).readAsStringSync();
      final fileJson = jsonDecode(fileRaw);

      final item = Item(
          name: fileJson['name'],
          fishColor: fileJson['fishColor'],
          contributionType: fileJson['contributionType'],
          contributionDescription: fileJson['contributionDescription'],
          contributionLinkRepository: fileJson['contributionLinkRepository']);

      assert(_fieldsFilled(item), 'All fields must be filled');
      assert(
          _isContributionDescriptionLengthValid(item.contributionDescription), 'Contribution description length must be shorter than 140 characters');
      assert(_isColorValid(item.fishColor), 'Fish color must be [AZUL, VERMELHO, VERDE, AMARELO, ROSA]');
      assert(_isContributionTypeValid(item.contributionType),
          'Contribution type must be [DESAFIO_TECNICO, ENTREVISTA_PARTICIPACAO, ENTREVISTA_AVALIACAO_TESTE, CAFE_COM_CODIGO, CONTRIBUICAO_COMUNIDADE, ARTIGO_BLOG_DEXTRA]');
    });
  });
}

class Item {
  String name;
  String fishColor;
  String contributionType;
  String contributionDescription;
  String contributionLinkRepository;

  Item({this.name, this.fishColor, this.contributionType, this.contributionDescription, this.contributionLinkRepository});
}

bool _fieldsFilled(item) {
  bool requiredFieldsOK =
      _isNotEmpty(item.name) && _isNotEmpty(item.fishColor) && _isNotEmpty(item.contributionType) && _isNotEmpty(item.contributionDescription);

  final contributionType = 'ItemType.${item.contributionType.toUpperCase()}';

  bool repositoryLinkValid = (!_isNotEmpty(item.contributionLinkRepository) &&
          (contributionType != ItemType.CONTRIBUICAO_COMUNIDADE.toString() && contributionType != ItemType.DESAFIO_TECNICO.toString())) ||
      _isNotEmpty(item.contributionLinkRepository);

  return requiredFieldsOK && repositoryLinkValid;
}

bool _isNotEmpty(value) {
  return value != null && value.toString().trim() != '';
}

bool _isContributionDescriptionLengthValid(value) {
  return value.length <= 140;
}

bool _isColorValid(color) {
  return ['BLUE', 'RED', 'GREEN', 'YELLOW', 'PINK'].contains(color.toUpperCase());
}

bool _isContributionTypeValid(contributionType) {
  return ItemType.values.map((element) => element.toString()).contains('ItemType.${contributionType.toUpperCase()}');
}
