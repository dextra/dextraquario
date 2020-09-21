import '../lib/fish_info.dart';
import 'read_files.dart';

void main() {
  final itemsByPath = ReadFiles.itemsByPath();

  if (itemsByPath.length > 0) {
    itemsByPath.values.reduce((value, element) {
      value.addAll(element);
      return value;
    }).forEach((element) {
      checkItem(element);
    });
  }
}

void checkItem(item) {
  print(item.name);
  assert(_fieldsFilled(item), 'All fields must be filled');
  assert(_isContributionDescriptionLengthValid(item.contributionDescription),
      'Contribution description length must be shorter than 140 characters');
  assert(_isColorValid(item.fishColor),
      'Fish color must be [AZUL, VERMELHO, VERDE, AMARELO, ROSA]');
  assert(_isContributionTypeValid(item.contributionType),
      'Contribution type must be [DESAFIO_TECNICO, ENTREVISTA_PARTICIPACAO, ENTREVISTA_AVALIACAO_TESTE, CAFE_COM_CODIGO, CONTRIBUICAO_COMUNIDADE, ARTIGO_BLOG_DEXTRA, CHAPA]');
}

bool _fieldsFilled(item) {
  bool requiredFieldsOK = _isNotEmpty(item.name) &&
      _isNotEmpty(item.fishColor) &&
      _isNotEmpty(item.contributionType) &&
      _isNotEmpty(item.contributionDescription);

  final contributionType = 'ItemType.${item.contributionType.toUpperCase()}';

  bool repositoryLinkValid = (!_isNotEmpty(item.contributionLinkRepository) &&
          (contributionType != ItemType.CONTRIBUICAO_COMUNIDADE.toString() &&
              contributionType != ItemType.DESAFIO_TECNICO.toString())) ||
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
  return ['BLUE', 'RED', 'GREEN', 'YELLOW', 'PINK']
      .contains(color.toUpperCase());
}

bool _isContributionTypeValid(contributionType) {
  return ItemType.values
      .map((element) => element.toString())
      .contains('ItemType.${contributionType.toUpperCase()}');
}
