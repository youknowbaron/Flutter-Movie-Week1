import 'dart:async';
import 'dart:convert';

import 'api.dart';

class Movie {
  final int id;
  final bool adult;
  final String overview;
  final String releaseDate;
  final String title;
  final String posterPath;
  final String backdropPath;
  final double popularity;
  final int voteCount;
  final double voteAverage;

  Movie(
      {this.id,
      this.adult,
      this.overview,
      this.releaseDate,
      this.title,
      this.posterPath,
      this.backdropPath,
      this.popularity,
      this.voteCount,
      this.voteAverage});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        adult: json['adult'],
        overview: json['overview'],
        releaseDate: json['release_date'],
        title: json['title'],
        posterPath: json['poster_path'],
        backdropPath: json['backdrop_path'],
        popularity: json['popularity'],
        voteCount: json['vote_count'],
        voteAverage: json['vote_average']);
  }
}

class NowPlaying {
  final int page;
//  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  NowPlaying({this.page, this.totalPages, this.totalResults});

  factory NowPlaying.fromJson(Map<String, dynamic> json) {
    return NowPlaying(
        page: json['page'],
//        results: json['results'],
        totalPages: json['total_pages'],
        totalResults: json['total_results']);
  }
}

//Future<NowPlaying> fetchNowPlaying() async {
//  final responseBody = Api.callApi('/now_playing');
//  print('fetchNowPlaying $responseBody');
//  return NowPlaying.fromJson(json.decode(responseBody));
//}
