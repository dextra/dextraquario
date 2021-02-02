import 'package:dextraquario/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  String collection = "users";
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void createUser(
      {String id, String name, String photo, bool admin = false, int score}) {
    firebaseFirestore
        .collection(collection)
        .doc(id)
        .set({"name": name, "photo": photo, "admin": admin, "score": score});
  }

  Future<UserModel> getUserById(String id) =>
      firebaseFirestore.collection(collection).doc(id).get().then((doc) {
        return UserModel.fromSnapshot(doc);
      });

  Future<bool> doesUserExist(String id) async => firebaseFirestore
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
