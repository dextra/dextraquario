import 'package:dextraquario/helper/constants.dart';
import 'package:dextraquario/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  String collection = "users";

  void createUser({
    String id,
    String name,
    String email,
  }) {
    firebaseFirestore.collection(collection).doc(id).set({
      "name": name,
      "id": id,
      "email": email,
    });
  }
  Future<UserModel> getUserId(String id) => 
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

