import 'package:http/http.dart' as http;
import 'dart:convert';

class EcoLensService{

  ///fashion qty
  ///food kg

  Future<Map<String,dynamic>> ecoLensApiCall(String commaSeparatedLabels) async{

    print(commaSeparatedLabels);

    final res = await http.get(
      Uri.parse("https://floating-citadel-22222.herokuapp.com/getcarbonfootprint?item=$commaSeparatedLabels"),
    );

    print(res.body);

    var jsonRes = json.decode(res.body);

    print(jsonRes);


    return jsonRes;

  }
}