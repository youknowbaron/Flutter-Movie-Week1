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
  final num popularity;
  final int voteCount;
  final num voteAverage;

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
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  NowPlaying({this.page, this.results, this.totalPages, this.totalResults});

  factory NowPlaying.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Movie> movies = list.map((i) => Movie.fromJson(i)).toList();
    return NowPlaying(
        page: json['page'],
        results: movies,
        totalPages: json['total_pages'],
        totalResults: json['total_results']);
  }

  List<Movie> createMovieList(List data) {
    List<Movie> list = new List();
    for (final movie in data) {
      final _movie = Movie.fromJson(movie);
      list.add(_movie);
    }
    return list;
  }
}
