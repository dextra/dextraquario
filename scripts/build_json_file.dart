import 'package:dextraquario/fish_info.dart';

import 'read_files.dart';
import 'dart:io';
import 'dart:convert';

void main() {
  final fishes = ReadFiles.itemsByPath().entries.map((e) {
    final rawItems = e.value;

    final fishItems = rawItems.map((rawFishItem) {
      return FishItem(
          name: ItemType.values.firstWhere((e) =>
              e.toString() == 'ItemType.${rawFishItem.contributionType}'),
          description: rawFishItem.contributionDescription,
          link: rawFishItem.contributionLinkRepository);
    }).toList();

    return FishInfo(
        name: rawItems.last.name,
        fishColor: rawItems.last.fishColor.toLowerCase(),
        fishItems: fishItems);
  }).toList();

  fishes.sort((a, b) => b.fishItems.length - a.fishItems.length);
  for (int i = 0; i < fishes.length; i++) {
    fishes[i].ranking = i + 1;
  }

  final fishesJson = {'fishes': fishes.map((fish) => fish.toJson()).toList()};

  File file = File('./assets/fishes.json');
  file.writeAsString(jsonEncode(fishesJson));
}
