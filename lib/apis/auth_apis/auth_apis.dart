import 'package:connectwith/models/user/address_info.dart';
import 'package:connectwith/models/user/contact_info.dart';
import 'package:connectwith/models/user/custom_button.dart';
import 'package:connectwith/models/user/user.dart';
import 'package:connectwith/utils/helper_functions/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' ;

import '../../screens/home_screens/home_main_screen.dart';
import '../../side_transitions/left_right.dart';
import '../init/config.dart';

class AuthApi{

  static Future<void> signIn(BuildContext context, String email, String password) async {
    try {
      await Config.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      HelperFunctions.showToast("Login Successful!");
      Navigator.pushReplacement(context, LeftToRight(HomeScreen()));
    } on FirebaseAuthException catch (e) {
      HelperFunctions.showToast("Something went wrong") ;
    } catch (e) {
      HelperFunctions.showToast("Something went wrong") ;
    }
  }

  static Future<void> signUp(BuildContext context, String email, String password, String name) async {
    try {

      final existingUser = await AuthApi.userExistsEmail(email);
      if (existingUser) {
        HelperFunctions.showToast('This email is already in use.');
        return;
      }
      UserCredential userCredential = await Config.auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await createUserEmail(userCredential, email, password, name);
      HelperFunctions.showToast("Successfully registered!");

    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email format.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'Password is too weak.';
      } else {
        errorMessage = 'An unknown error occurred.';
      }

      HelperFunctions.showToast(errorMessage);
    } catch (e) {
      HelperFunctions.showToast("Something went wrong!");
    }
  }



  static Future<void> createUserEmail(
      UserCredential userCredential, String email, String password,String name) async {

    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final appUser = AppUser(

      userID: userCredential.user!.uid,
      email: email,
      userName: name,
      pronoun: "",
      additionalName: "",
      profilePath: "",
      coverPath: "",
      headLine: "",
      positions: [],
      address: Address(
        cityName: "",
        stateName: "",
        countryName: "",
      ),
      about: "",
      followers: 0,
      following: 0,
      profileViews: 0,
      searchCount: 0,
      testScores: [],
      skills: [],
      lacertificate: [],
      language: [],
      projects: [],
      experiences: [],
      educations: [],
      courses: [],
      button: CustomButton(
        display: false,
        link: "",
        linkText: "",
      ),
      info: ContactInfo(
        phoneNumber: "",
        phoneType: "",
        address: "",
        birthday: "",
        email: email,
        website: Website(
          url: "",
          type: "",
        ),
      ),
      createAt: time,
    );
    print("#come") ;
    return await Config.firestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .set(appUser.toJson());
  }
  

  static Future<bool> userExistsEmail(String userId) async {
    return (await Config.firestore.collection('users').doc(userId).get()).exists;
  }

}