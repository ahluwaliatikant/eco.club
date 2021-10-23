import 'package:ecoclub/models/flash_card_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetCards {
  Future<List<FlashCardModel>> getAllCards() async {
    final response = await http.get(
      Uri.parse(
          "https://api.storyblok.com/v2/cdn/stories?cv=1&token=mjLuoHnd0ZvUGm4eQqNibQtt"),
    );

    print(response.body);

    var jsonResponse = json.decode(response.body);

    jsonResponse = jsonResponse["stories"];

    print("JSON RES");
    print(jsonResponse);
    List<FlashCardModel> flashCardsList = [];

    jsonResponse.forEach((flashCard) {
      FlashCardModel myFlashCard = new FlashCardModel(
          title: flashCard["content"]["title"],
          content: flashCard["content"]["content"],
          image: flashCard["content"]["image"],
      );

      flashCardsList.add(myFlashCard);

    });

    return flashCardsList;
  }
}
