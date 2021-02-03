import 'package:dextraquario/helper/constants.dart';

import 'package:dextraquario/models/contribution_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

enum ApprovalStatus { APPROVED, DENIED, ANALYZING }

extension ApprovalStatusExtension on ApprovalStatus {
  String get status => _describeEnum(this).split('.').last;

  String _describeEnum(Object approvalStatusEntry) {
    return approvalStatusEntry.toString();
  }
}

class ContributionServices {
  String collection = "contributions";
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  /*
  CONSTANTES DO APPROVAL
  "ANALYZING" -- em analise
  "APPROVED" -- aceito
  "DENIED" -- negado
  */

  void createContribution(String user_id, DateTime date, String description,
      String contribution_link, String category,
      [ApprovalStatus approval = ApprovalStatus.ANALYZING]) {
    firebaseFirestore.collection(collection).add({
      "user_id": user_id,
      "date": date,
      "description": description,
      "contribution_link": contribution_link,
      "category": category,
      "approval": approval.status,
    });
  }

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

  //Get all contributions depending on the approval
  Future<List<ContributionModel>> getContributionsByApprovalStatus(
      ApprovalStatus approvalStatus) async {
    String approvalString = approvalStatus.status;
    List<ContributionModel> contributions = [];

    final data = await firebaseFirestore
        .collection(collection)
        .where("approval", isEqualTo: approvalString)
        .get();

    await Future.forEach(data.docs, (item) {
      contributions.add(ContributionModel.fromSnapshot(item));
    });

    return contributions;
  }
}
