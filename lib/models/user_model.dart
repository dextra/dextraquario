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

  // GET
  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _name = snapshot.data()[NAME];
    _photo = snapshot.data()[PHOTO];
    _score = snapshot.data()[SCORE];
    _admin = snapshot.data()[ADMIN];
  }
/*
  void printUser() {
    print('''
id: $id
name: $name
photo: $photo
score: $score
admin: $admin
    ''');
  }*/
}
