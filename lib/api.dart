import 'dart:convert' show json, utf8;
import 'dart:io';
import 'movie.dart';

class Api {
  static final HttpClient httpClient = HttpClient();
  static final String baseUrl = "api.themoviedb.org";
  static final String appendMovie = '/3/movie';
  static final String apiKey = "4de371dea47b9a5dcd86c1cf83c48d4e";

  static Future<NowPlaying> callApi(String url) async {
    final uri = Uri.https(baseUrl, '$appendMovie$url', {
      'api_key': apiKey,
    });
    try {
      final httpRequest = await httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != 200) {
        throw Exception('Failed to load data.');
      }
      final responseBody = await httpResponse.transform(utf8.decoder).join();
      print('$responseBody');
      return NowPlaying.fromJson(json.decode(responseBody));
    } on Exception catch (e) {
      print('$e');
      return null;
    }
  }
}
