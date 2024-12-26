import 'package:connectwith/models/user/contact_info.dart';
import 'package:connectwith/models/user/course_and_liecence.dart';
import 'package:connectwith/models/user/custom_button.dart';
import 'package:connectwith/models/user/education.dart';
import 'package:connectwith/models/user/experience.dart';
import 'package:connectwith/models/user/project.dart';
import 'package:connectwith/models/user/skills.dart';
import 'package:connectwith/models/user/speak_language.dart';
import 'package:connectwith/models/user/test_score.dart';

import 'address_info.dart';


class AppUser {

  String? userID;
  String? email;
  String? userName;
  String? pronoun;
  String? additionalName;
  String? profilePath;
  String? coverPath;
  String? headLine;
  List<Experience>? positions;
  Address? address;
  String? about;
  int? followers;
  int? following;
  int? profileViews;
  int? searchCount;
  List<TestScores>? testScores;
  List<Skill>? skills;
  List<Project>? projects;
  List<SpeakLanguage>? language;
  List<Experience>? experiences;
  List<Education>? educations;
  CustomButton? button;
  List<Course>? courses;
  List<LicenseAndCertificate>? lacertificate;
  ContactInfo? info;
  String? createAt;

  AppUser({
    this.userID,
    this.email,
    this.userName,
    this.pronoun,
    this.additionalName,
    this.profilePath,
    this.coverPath,
    this.headLine,
    this.positions,
    this.address,
    this.about,
    this.followers,
    this.following,
    this.profileViews,
    this.searchCount,
    this.testScores,
    this.skills,
    this.projects,
    this.language,
    this.experiences,
    this.educations,
    this.button,
    this.courses,
    this.lacertificate,
    this.info,
    this.createAt,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userID'] = userID;
    map['email'] = email;
    map['userName'] = userName;
    map['pronoun'] = pronoun;
    map['additionalName'] = additionalName;
    map['profilePath'] = profilePath;
    map['coverPath'] = coverPath;
    map['headLine'] = headLine;
    map['create-at'] = createAt ;
    if (positions != null) {
      map['curPosition'] = positions!.map((e) => e.toJson()).toList();
    }
    if (address != null) {
      map['address'] = address!.toJson();
    }
    map['about'] = about;
    map['followers'] = followers;
    map['following'] = following;
    map['profileViews'] = profileViews;
    map['searchCount'] = searchCount;
    if (testScores != null) {
      map['testScores'] = testScores!.map((e) => e.toJson()).toList();
    }
    if (skills != null) {
      map['skills'] = skills!.map((e) => e.toJson()).toList();
    }
    if (projects != null) {
      map['projects'] = projects!.map((e) => e.toJson()).toList();
    }
    if (language != null) {
      map['languages'] = language!.map((e) => e.toJson()).toList();
    }
    if (experiences != null) {
      map['experiences'] = experiences!.map((e) => e.toJson()).toList();
    }
    if (educations != null) {
      map['educations'] = educations!.map((e) => e.toJson()).toList();
    }
    if (courses != null) {
      map['courses'] = courses!.map((e) => e.toJson()).toList();
    }
    if (lacertificate != null) {
      map['licensesAndCertificates'] = lacertificate!.map((e) => e.toJson()).toList();
    }
    if (info != null) {
      map['info'] = info!.toJson();
    }
    return map;
  }

  factory AppUser.fromJson(dynamic json) {
    return AppUser(
      userID: json['userID'],
      email: json['email'],
      userName: json['userName'],
      pronoun: json['pronoun'],
      additionalName: json['additionalName'],
      profilePath: json['profilePath'],
      coverPath: json['coverPath'],
      headLine: json['headLine'],
      createAt: json['create-at'],
      positions: json['curPosition'] != null
          ? (json['curPosition'] as List)
          .map((e) => Experience.fromJson(e))
          .toList()
          : null,
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      about: json['about'],
      followers: json['followers'],
      following: json['following'],
      profileViews: json['profileViews'],
      searchCount: json['searchCount'],
      info: json['info'] != null ? ContactInfo.fromJson(json['info']) : null,
      button: json['button'] != null ? CustomButton.fromJson(json['button']) : null,
      testScores: json['testScores'] != null
          ? (json['testScores'] as List)
          .map((e) => TestScores.fromJson(e))
          .toList()
          : null,
      skills: json['skills'] != null
          ? (json['skills'] as List)
          .map((e) => Skill.fromJson(e))
          .toList()
          : [],
      projects: json['projects'] != null
          ? (json['projects'] as List)
          .map((e) => Project.fromJson(e))
          .toList()
          : [],
      language: json['language'] != null
          ? (json['language'] as List)
          .map((e) => SpeakLanguage.fromJson(e))
          .toList()
          : [],
      experiences: json['experiences'] != null
          ? (json['experiences'] as List)
          .map((e) => Experience.fromJson(e))
          .toList()
          : [],
      educations: json['educations'] != null
          ? (json['educations'] as List)
          .map((e) => Education.fromJson(e))
          .toList()
          : [],
      courses: json['courses'] != null
          ? (json['courses'] as List)
          .map((e) => Course.fromJson(e))
          .toList()
          : [],
      lacertificate: json['lacertificate'] != null
          ? (json['lacertificate'] as List)
          .map((e) => LicenseAndCertificate.fromJson(e))
          .toList()
          : [],
    );
  }
}
