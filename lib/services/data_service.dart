import 'package:cloud_firestore/cloud_firestore.dart';

import 'hive_service.dart';
import '../model/home_model.dart';
import '../model/user_model.dart';

class FirestoreService {
  static final _instance = FirebaseFirestore.instance;

  static const String usersFolder = 'users';
  static const String homesFolder = 'homes';
  static const String adminFolder = 'adminHomes';
  static const String favoriteHomesFolder = 'favoriteHomes';

  // * User Related
  static Future<void> storeUser(UserModel user) async {
    await _instance.collection(usersFolder).doc(user.id).set(user.toJson());
  }

  // * House Related
  static Future<void> storeHouse(HomeModel house) async {
    final query = _instance
        .collection(homesFolder)
        .doc(house.sellType)
        .collection(house.homeType);

    final queryToUser = _instance
        .collection(usersFolder)
        .doc(house.userId)
        .collection(homesFolder);

    await query.doc(house.id).set(house.toJson());
    await queryToUser.doc(house.id).set(house.toJson());
    await deleteHouseFromAdminFolder(house);
  }

  // static Future<void> updateHouse(HomeModel house) async {
  //   final query = _instance
  //       .collection(homesFolder)
  //       .doc(house.sellType)
  //       .collection(house.homeType);
  //
  //   final queryToUser = _instance
  //       .collection(usersFolder)
  //       .doc(house.userId)
  //       .collection(homesFolder);
  //
  //   await query.doc(house.id).update(house.toJson());
  //   await queryToUser.doc(house.id).update(house.toJson());
  // }

  static Future<List<UserModel>> getUser() async {
    List<UserModel> users = [];
    var querySnapshot = await _instance.collection(usersFolder).get();

    for (var user in querySnapshot.docs) {
      users.add(UserModel.fromJson(user.data()));
    }

    return users;
  }

  static Future<void> deleteUser(String userId) async {
    await _instance.collection(usersFolder).doc(userId).delete();
  }

  static Future<void> deleteHouse(HomeModel house) async {
    await _instance
        .collection(homesFolder)
        .doc(house.sellType)
        .collection(house.homeType)
        .doc(house.id)
        .delete();
    await _instance
        .collection(usersFolder)
        .doc(house.userId)
        .collection(homesFolder)
        .doc(house.id)
        .delete();
  }

  static Future<void> deleteHouseFromAdminFolder(HomeModel house) async {
    await _instance
        .collection(adminFolder)
        .doc(house.sellType)
        .collection(house.homeType)
        .doc(house.id)
        .delete();
  }
}
