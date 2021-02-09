import 'package:dextraquario/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  String collection = "users";
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // Create user
  void createUser(String id, String name, String photo,
      [bool admin = false, int score = 0]) {
    firebaseFirestore
        .collection(collection)
        .doc(id)
        .set({"name": name, "photo": photo, "admin": admin, "score": score});
  }

  // Get user by ID
  Future<UserModel> getUserById(String id) =>
      firebaseFirestore.collection(collection).doc(id).get().then((doc) {
        return UserModel.fromSnapshot(doc);
      });

  // Does the user exists
  Future<bool> doesUserExist(String id) async => firebaseFirestore
      .collection(collection)
      .doc(id)
      .get()
      .then((value) => value.exists);

  // Get all users
  Future<List<UserModel>> getAll() async =>
      firebaseFirestore.collection(collection).get().then((result) {
        List<UserModel> users = [];
        for (DocumentSnapshot user in result.docs) {
          users.add(UserModel.fromSnapshot(user));
        }
        return users;
      });

  // Is the user an admin
  Future<bool> isAdmin(String user_id) async {
    UserModel user = await getUserById(user_id);

    return user.admin;
  }
}
