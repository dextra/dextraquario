import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  // constantes com os nomes dos documentos no banco de dados
  static const ID = "id";
  static const NAME = "name";
  static const PHOTO = "photo";
  static const SCORE = "score";
  static const ADMIN = "admin";

  String _id;
  String _name;
  String _photo;
  int _score;
  bool _admin;

  //  getters
  String get id => _id;
  String get name => _name;
  String get photo => _photo;
  int get score => _score;
  bool get admin => _admin;

  String getShortName() {
    List<String> nameArray = _name.split(" ");
    String shortName = '${nameArray.first} ${nameArray.last}';
    return shortName;
  }

  // GET
  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.id;
    _name = snapshot.data()[NAME];
    _photo = snapshot.data()[PHOTO];
    _score = snapshot.data()[SCORE];
    _admin = snapshot.data()[ADMIN];
  }
}
