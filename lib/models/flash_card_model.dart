class FlashCardModel {

  String image;
  String title;
  String content;

  FlashCardModel({
    required this.title,
    required this.content,
    required this.image,
  });

  factory FlashCardModel.fromJson(Map<String,dynamic> json){
    return FlashCardModel(
        title: json["title"],
        content: json["content"],
        image: json["image"],
    );
  }

}