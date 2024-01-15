import 'dart:ffi';

class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String bio;
  final String link;
  final String bitrhday;
  final bool hasAvatar;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.bio,
    required this.link,
    required this.bitrhday,
    required this.hasAvatar,
  });

  UserProfileModel.empty()
      : uid = "",
        email = "",
        name = "",
        bio = "",
        link = "",
        bitrhday = "",
        hasAvatar = false;

  Map<String, String> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "bio": bio,
      "link": link,
      "bitrhday": bitrhday,
    };
  }

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"] ?? "",
        email = json["email"] ?? "",
        name = json["name"] ?? "",
        bio = json["bio"] ?? "",
        link = json["link"] ?? "",
        hasAvatar = json["hasAvatar"] ?? false,
        bitrhday = json["bitrhday"] ?? "";

  UserProfileModel copywith({
    String? uid,
    String? email,
    String? name,
    String? bio,
    String? link,
    String? bitrhday,
    bool? hasAvatar,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      link: link ?? this.link,
      bitrhday: bitrhday ?? this.bitrhday,
      hasAvatar: hasAvatar ?? this.hasAvatar,
    );
  }
}
