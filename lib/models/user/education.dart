class Education {
  String? school;
  String? degree;
  String? fieldOfStudy;
  String? startDate;
  String? endDate;
  String? grade;
  String? description;
  List<String>? skills;
  String? media;

  Education({
    this.school,
    this.degree,
    this.fieldOfStudy,
    this.startDate,
    this.endDate,
    this.grade,
    this.description,
    this.skills,
    this.media,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['school'] = school;
    map['degree'] = degree;
    map['fieldOfStudy'] = fieldOfStudy;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['grade'] = grade;
    map['description'] = description;
    map['skills'] = skills;
    map['media'] = media;

    return map;
  }

  factory Education.fromJson(dynamic json) {
    return Education(
      school: json['school'],
      degree: json['degree'],
      fieldOfStudy: json['fieldOfStudy'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      grade: json['grade'],
      description: json['description'],
      skills: json['skills'].cast<String>(),
      media: json['media'],
    );
  }
}