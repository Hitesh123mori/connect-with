import 'package:connectwith/models/user/project.dart';
import 'package:connectwith/models/user/user.dart';

class Skill {
  String? name;
  List<AppUser>? endorsedPeoples;
  List<Project>? projects;

  Skill({
    this.name,
    this.endorsedPeoples,
    this.projects,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['endorsedPeoples'] = endorsedPeoples?.map((e) => e.toJson()).toList();
    map['projects'] = projects?.map((e) => e.toJson()).toList();

    return map;
  }

  factory Skill.fromJson(dynamic json) {
    return Skill(
      name: json['name'],
      endorsedPeoples: json['endorsedPeoples']!= null
          ? (json['endorsedPeoples'] as List)
          .map((e) => AppUser.fromJson(e))
          .toList()
          : null,
      projects: json['projects']!= null
          ? (json['projects'] as List)
          .map((e) => Project.fromJson(e))
          .toList()
          : null,
    );
  }
}