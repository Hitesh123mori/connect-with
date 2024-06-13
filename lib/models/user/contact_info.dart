class Website {
  String? url;
  String? type;

  Website({
    this.url,
    this.type,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['type'] = type;

    return map;
  }

  factory Website.fromJson(dynamic json) {
    return Website(
      url: json['url'],
      type: json['type'],
    );
  }
}

class ContactInfo {
  String? phoneNumber;
  String? phoneType;
  String? address;
  String? birthday;
  String? email;
  Website? website;

  ContactInfo({
    this.phoneNumber,
    this.phoneType,
    this.address,
    this.birthday,
    this.email,
    this.website,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phoneNumber'] = phoneNumber;
    map['phoneType'] = phoneType;
    map['address'] = address;
    map['birthday'] = birthday;
    map['email'] = email;
    map['website'] = website?.toJson();

    return map;
  }

  factory ContactInfo.fromJson(dynamic json) {
    return ContactInfo(
      phoneNumber: json['phoneNumber'],
      phoneType: json['phoneType'],
      address: json['address'],
      birthday: json['birthday'],
      email: json['email'],
      website: json['website'] != null ? Website.fromJson(json['website']) : null,
    );
  }
}