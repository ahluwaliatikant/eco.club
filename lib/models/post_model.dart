import 'package:ecoclub/models/user_model.dart';

class Post {
  String content;
  User createdBy;
  String imageUrl;

  Post({
    required this.content,
    required this.createdBy,
    required this.imageUrl,
  });

  factory Post.fromJson(Map<String,dynamic> json){
    return Post(
      content: json["content"],
      createdBy: json["createdBy"],
      imageUrl: json["imageUrl"],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "content": this.content,
      "createdBy": this.createdBy.toJson(),
      "imageUrl": this.imageUrl,
    };
  }

}