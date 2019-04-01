class Genre {
  final int id;
  final String name;

  Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ProductionCountry {
  final String iso;
  final String name;

  ProductionCountry({this.iso, this.name});

  factory ProductionCountry.fromJson(Map<String, dynamic> json) {
    return ProductionCountry(
        iso: json['iso_3166_1'],
        name: json['name'],
    );
  }
}

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
  final String tagLine;
  final int runtime;
  final List<Genre> genres;
  final List<ProductionCountry> productionCountries;

  Movie({this.id,
    this.adult,
    this.overview,
    this.releaseDate,
    this.title,
    this.posterPath,
    this.backdropPath,
    this.popularity,
    this.voteCount,
    this.voteAverage,
    this.tagLine,
    this.runtime,
    this.genres,
    this.productionCountries,
  });

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
        voteAverage: json['vote_average'],
    );
  }

  factory Movie.fromJsonDetail(Map<String, dynamic> json) {
    var list = json['genres'] as List;
    List<Genre> genres = list.map((i) => Genre.fromJson(i)).toList();
    list = json['production_companies'] as List;
    List<ProductionCountry> productionCountries = list.map((i) => ProductionCountry.fromJson(i)).toList();
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
        voteAverage: json['vote_average'],
        tagLine: json['tagline'],
        runtime: json['runtime'],
        genres: genres,
        productionCountries: productionCountries,
    );
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
}
