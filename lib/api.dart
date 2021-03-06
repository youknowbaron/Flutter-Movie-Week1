import 'dart:convert' show json, utf8;
import 'dart:io';
import 'movie.dart';
import 'const.dart';

class Api {
  static final HttpClient httpClient = HttpClient();

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
  
  static Future<Movie> getMovie(int id) async {
    final reponse = await callApi('/$id');
    return Movie.fromJsonDetail(json.decode(reponse.toString()));
  }
}
