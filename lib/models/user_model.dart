class User {

  String uuid;
  String name;
  String profilePicUrl;

  User({
    required this.profilePicUrl,
    required this.name,
    required this.uuid,
  });

  factory User.fromJson(Map<String,dynamic> json){
    return User(
      uuid: json["uuid"],
      name: json["name"],
      profilePicUrl: json["profilePicUrl"],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "uuid": this.uuid,
      "name": this.name,
      "profilePicUrl": this.profilePicUrl,
    };
  }

}