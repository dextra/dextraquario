import 'package:cloud_firestore/cloud_firestore.dart';

class ContributionModel {
  // constantes com os nomes dos documentos no banco de dados
  static const CONTRIBUTION_ID = "contribution_id";
  static const USER_ID = "user_id";
  static const DATE = "date";
  static const CATEGORY = "category";
  static const LINK = "contribution_link";
  static const DESCRIPTION = "description";
  static const APPROVAL = "approval";

  String _contributionid;
  String _userid;
  DateTime _date;
  String _category;
  String _link;
  String _description;
  String _approval;

  //  getters
  String get contribution_id => _contributionid;
  String get user_id => _userid;
  DateTime get date => _date;
  String get category => _category;
  String get contribution_link => _link;
  String get description => _description;
  String get approval => _approval;

  // GET
  ContributionModel.fromSnapshot(DocumentSnapshot snapshot) {
    _contributionid = snapshot.data()[CONTRIBUTION_ID];
    _userid = snapshot.data()[USER_ID];
    _date = snapshot.data()[DATE];
    _category = snapshot.data()[CATEGORY];
    _link = snapshot.data()[LINK];
    _description = snapshot.data()[DESCRIPTION];
    _approval = snapshot.data()[APPROVAL];
  }
}
