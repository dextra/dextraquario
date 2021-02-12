import 'package:dextraquario/models/contribution_model.dart';
import 'package:dextraquario/models/user_model.dart';
import 'package:dextraquario/services/contribution_service.dart';
import 'package:dextraquario/services/user_service.dart';

class FishServices {
  final UserModel user;
  String userID;
  List<ContributionModel> _contributions;

  List<ContributionModel> get contributions => _contributions;

  FishServices(this.user) {
    this.userID = user.id;
  }

  Future loadFishInfo() async {
    _contributions =
        await ContributionServices().getContributionsByUser(this.userID);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> listContributions = [];

    _contributions.forEach((contribution) => {
          listContributions.add({
            'name': contribution.category,
            'description': contribution.description,
            'link': contribution.contribution_link,
            'user_id': contribution.user_id,
          })
        });

    return {
      'name': this.user.name,
      'ranking': this.user.score,
      'items': listContributions,
      'user_id': this.userID,
    };
  }
}
