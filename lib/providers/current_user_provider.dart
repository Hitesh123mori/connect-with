import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/user/user.dart';


class AppUserProvider extends ChangeNotifier{
  AppUser? user;

  void notify(){
    notifyListeners();
  }

  // Future initUser() async {
  //   String? uid = FirebaseAPIs.auth.currentUser?.uid;
  //   log("#authId: $uid");
  //   if(uid != null){
  //     user = AppUser.fromJson(await UserProfile.getUser(uid));
  //   }
  //   notifyListeners();
  //   log("#initUser complete");
  // }

  Future logOut() async {

    user  = null ;
    notifyListeners();
  }

}