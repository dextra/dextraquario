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
  String name;
  String description;
  String url;

  FishItem({this.name, this.description, this.url});

  FishItem.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        url = json['url'];
}
