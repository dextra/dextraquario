import 'package:dextraquario/helper/constants.dart';

import 'package:dextraquario/models/contribution_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

enum ApprovalStatus { APPROVED, DENIED, ANALYZING }

class ContributionServices {
  String collection = "contributions";
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  /*
  CONSTANTES DO APPROVAL
  "ANALYZING" -- em analise
  "ACCEPTED" -- aceito
  "DENIED" -- negado
  */

  void createContribution(
      [String id,
      String user_id,
      DateTime date,
      String description,
      String contribution_link,
      String category,
      ApprovalStatus approval]) {
    firebaseFirestore.collection(collection).doc(id).set({
      "user_id": user_id,
      "date": date,
      "description": description,
      "contribution_link": contribution_link,
      "category": category,
      "approval": approval.toString().split('.').last,
    });
  }

  // Get contribution by id
  Future<ContributionModel> getContributionById(String id) =>
      firebaseFirestore.collection(collection).doc(id).get().then((doc) {
        return ContributionModel.fromSnapshot(doc);
      });

  // Get contribution by user
  Future<ContributionModel> getContributionByUser(String id) =>
      firebaseFirestore.collection(collection).doc(id).get().then((doc) {
        return ContributionModel.fromSnapshot(doc);
      });

  // Does the contribution exists
  Future<bool> doesContributionExist(String id) async => firebase
      .collection(collection)
      .doc(id)
      .get()
      .then((value) => value.exists);

  // Get all contributions
  Future<List<ContributionModel>> getAll() async {
    List<ContributionModel> contributions = [];
    final data = await firebaseFirestore.collection(collection).get();

    await Future.forEach(data.docs, (item) {
      contributions.add(ContributionModel.fromSnapshot(item));
    });

    return contributions;
  }

  // Update the contribution approval status
  Future updateContributionApproval(
      String contribution_id, bool approved) async {
    String approvalStatus;

    if (approved) {
      approvalStatus = ApprovalStatus.APPROVED.toString().split('.').last;
    } else {
      approvalStatus = ApprovalStatus.DENIED.toString().split('.').last;
    }

    firebaseFirestore.collection(collection).doc(contribution_id).update({
      'approval': approvalStatus,
    });
  }
}
