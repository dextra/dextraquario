import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dextraquario/models/user_model.dart';
import 'package:dextraquario/services/user_service.dart';

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
  String _author;

  //  getters
  String get contribution_id => _contributionid;
  String get user_id => _userid;
  DateTime get date => _date.toDate();
  String get category => _category;
  String get contribution_link => _link;
  String get description => _description;
  String get approval => _approval;
  String get author => _author;

  // GET
  ContributionModel.fromSnapshot(DocumentSnapshot snapshot) {
    _contributionid = snapshot.id;
    _userid = snapshot.data()[USER_ID];
    _date = snapshot.data()[DATE];
    _category = snapshot.data()[CATEGORY];
    _link = snapshot.data()[LINK];
    _description = snapshot.data()[DESCRIPTION];
    _approval = snapshot.data()[APPROVAL];

    _initAuthor();
  }

  Future _initAuthor() async {
    UserModel user = await UserServices().getUserById(_userid);

    _author = user.name;
  }
}
