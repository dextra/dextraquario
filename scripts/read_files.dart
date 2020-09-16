import 'dart:io';
import 'dart:convert';
import 'item.dart';

class ReadFiles {
  static Map<String, List<Item>> itemsByPath() {
    final contributions = Directory('contributions');
    Map<String, List<Item>> items = {};

    contributions
        .listSync(recursive: false, followLinks: false)
        .forEach((element) {
      if (element.path != 'contributions/.gitkeep') {
        final userDir = Directory(element.path);

        userDir
            .listSync(recursive: false, followLinks: false)
            .forEach((element) {
          final fileRaw = File(element.path).readAsStringSync();

          assert(fileRaw != null && fileRaw != '', 'Empty file');

          final fileJson = jsonDecode(fileRaw);

          if (!items.containsKey(userDir.path)) {
            items.putIfAbsent(userDir.path, () => []);
          }

          items[userDir.path].add(Item(
              name: fileJson['name'],
              fishColor: fileJson['fishColor'],
              contributionType: fileJson['contributionType'],
              contributionDescription: fileJson['contributionDescription'],
              contributionLinkRepository:
                  fileJson['contributionLinkRepository']));
        });
      }
    });

    return items;
  }
}
