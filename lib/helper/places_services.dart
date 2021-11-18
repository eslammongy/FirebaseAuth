
import 'package:flutter_maps/data/searced_place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as converter;

class PlacesServices {
  final key = "AIzaSyCA771iw1egGmUDC83w4B34VQued4jWDiI";

  Future<List<PlaceSearch>> getAutoCompleteSearchedPlaces(String search) async {
    var url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$key";
    var response = await http.get(Uri.parse("https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$key"));
    var json = converter.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }


}
