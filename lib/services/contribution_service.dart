import 'package:dextraquario/helper/constants.dart';

import 'package:dextraquario/models/contribution_model.dart';
import 'package:dextraquario/models/user_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ContributionServices {
  String collection = "contributions";

  void createContribution(
      {String id,
      String user_id,
      String description,
      String contribution_link,
      String category,
      String approval}) {
    firebaseFirestore.collection(collection).doc(id).set({
      "user_id": user_id,
      "description": description,
      "contribution_link": contribution_link,
      "category": category,
      "approval": approval,
    });
  }

  // Get contribution by user
  Future<ContributionModel> getContributionByUser(String id) =>
      firebaseFirestore.collection(collection).doc(id).get().then((doc) {
        return ContributionModel.fromSnapshot(doc);
      });

  Future<bool> doesContributionExist(String id) async => firebaseFirestore
      .collection(collection)
      .doc(id)
      .get()
      .then((value) => value.exists);

  Future<List<UserModel>> getAll() async =>
      firebaseFirestore.collection(collection).get().then((result) {
        List<UserModel> users = [];
        for (DocumentSnapshot user in result.docs) {
          users.add(UserModel.fromSnapshot(user));
        }
        return users;
      });
}
