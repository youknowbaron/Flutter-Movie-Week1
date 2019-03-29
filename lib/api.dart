import 'dart:convert' show json, utf8;
import 'dart:io';
import 'movie.dart';

class Api {
  static final HttpClient httpClient = HttpClient();
  static const String BASE_URL = "api.themoviedb.org";
  static const String MOVIE = '/3/movie';
  static const String API_KEY = "4de371dea47b9a5dcd86c1cf83c48d4e";
  static const String NOW_PLAYING = '/now_playing';

  static Future<String> callApi(String url) async {
    final uri = Uri.https(BASE_URL, '$MOVIE$url', {
      'api_key': API_KEY,
    });
    try {
      final httpRequest = await httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != 200) {
        throw Exception('Failed to load data.');
      }
      final responseBody = await httpResponse.transform(utf8.decoder).join();
      print('$responseBody');
      return responseBody;
    } on Exception catch (e) {
      print('$e');
      return null;
    }
  }

  static Future<NowPlaying> getNowPlaying() async {
    // `await` help to get return of Future<T>
    final response = await callApi(NOW_PLAYING);
    return NowPlaying.fromJson(json.decode(response.toString()));
  }
}
