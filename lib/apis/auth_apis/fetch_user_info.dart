import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectwith/apis/init/config.dart';


class UserProfile{

  static final _collectionRef = Config.firestore.collection("users");


  static Future<Map<dynamic, dynamic>?> getUser(String userId) async {
    return await _collectionRef
        .doc(userId)
        .get()
        .then((value) => value.data())
        .onError((error, stackTrace) => {"error": error, "stackTrace": stackTrace});
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllAppUsers()  {
    return _collectionRef.snapshots();
  }


  static Future<bool> updateUserProfile(String? userId, Map<String, dynamic> fields) async {
    return await _collectionRef.doc("$userId").update(fields)
        .then((value) {
      log("#User Details updated");
      return true;
    })
        .onError((error, stackTrace) {
      log("#update-e: $error, $stackTrace");
      return false;
    });
  }






}