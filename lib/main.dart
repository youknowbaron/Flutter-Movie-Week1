import 'package:flutter/material.dart';
import 'package:movie_week1/movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'api.dart';
import 'const.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Now Playing Movie'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WillPopScope(
          child: Stack(
            children: <Widget>[
              Container(
                  child: new FutureBuilder<NowPlaying>(
                      future: Api.getNowPlaying(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xfff5a623)),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            itemBuilder: (context, index) => buildItem(
                                context, snapshot.data.results[index]),
                            itemCount: snapshot.data.results.length,
                          );
                        }
                      }))
            ],
          ),
          onWillPop: null),
    );
  }

  Widget buildItem(BuildContext context, Movie movie) {
    return Container(
      child: FlatButton(
        onPressed: null,
        child: Container(
          child: Row(
            children: <Widget>[
              Material(
                child: CachedNetworkImage(
                  imageUrl: '$BASE_URL_IMAGE$THUMBNAIL${movie.posterPath}',
                  placeholder: (context, url) => Container(
                        child: CircularProgressIndicator(
                          strokeWidth: 1.0,
                          valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                        ),
                        width: 50,
                        height: 50,
                      ),
                  width: 100,
                  height: 150,
                  fit: BoxFit.fitHeight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(16)),
                clipBehavior: Clip.hardEdge,
              ),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                movie.title,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                          isLogoAdult(movie.adult),
                        ],
                      ),
                      Container(
                        child: Text(
                          'Release date: ${movie.releaseDate}.',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Raleway',
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              color: Colors.black45),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 4),
                      ),
                      Container(
                        child: Text(
                          'Popularity: ${movie.popularity}',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 8),
                      ),
                      Container(
                        child: SmoothStarRating(
                          color: Colors.blueAccent,
                          starCount: 10,
                          size: 20,
                          rating: movie.voteAverage.toDouble(),
                        ),
                        margin: EdgeInsets.only(top: 24),
                      ),
//                      Image.asset(
//                        'images/eightteenplus.png',
//                        width: 40,
//                        height: 40,
//                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(left: 16),
                ),
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        ),
      ),
    );
  }

  Widget isLogoAdult(bool adult) {
    if (adult)
      return Image.asset(
        'images/eightteenplus.png',
        width: 24,
        height: 24,
      );
    else
      return Text('');
  }
}
