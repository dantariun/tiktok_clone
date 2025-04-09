class VideoModel {
  final String title;
  final String description;
  final String fileUrl;
  final String thumbnailUrl;
  final String creatorUid;
  final String creator;
  final int likes;
  final int comments;
  final int createAt;

  VideoModel(
      {required this.description,
      required this.fileUrl,
      required this.thumbnailUrl,
      required this.creatorUid,
      required this.creator,
      required this.likes,
      required this.comments,
      required this.createAt,
      required this.title});

  VideoModel.fromjson(Map<String, dynamic> json)
      : title = json["title"],
        description = json["description"],
        fileUrl = json["fileUrl"],
        thumbnailUrl = json["thumbnailUrl"],
        creatorUid = json["creatorUid"],
        creator = json["creator"],
        likes = json["likes"],
        comments = json["comments"],
        createAt = json["createAt"];

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "fileUrl": fileUrl,
      "thumbnailUrl": thumbnailUrl,
      "creatorUid": creatorUid,
      "creator": creator,
      "likes": likes,
      "comments": comments,
      "createAt": createAt,
    };
  }
}
