class Experience {
  String? title;
  String? employementType;
  String? companyName;
  String? location;
  String? startDate;
  String? endDate;
  String? description;
  List<String>? skills;
  String? media;

  Experience({
    this.title,
    this.employementType,
    this.companyName,
    this.location,
    this.startDate,
    this.endDate,
    this.description,
    this.skills,
    this.media,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['employementType'] = employementType;
    map['companyName'] = companyName;
    map['location'] = location;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['description'] = description;
    map['skills'] = skills;
    map['media'] = media;

    return map;
  }

  factory Experience.fromJson(dynamic json) {
    return Experience(
      title: json['title'],
      employementType: json['employementType'],
      companyName: json['companyName'],
      location: json['location'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      description: json['description'],
      skills: json['skills'].cast<String>(),
      media: json['media'],
    );
  }
}