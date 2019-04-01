import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'api.dart';
import 'movie.dart';
import 'util.dart';

class DetailMovie extends StatelessWidget {
  final String title;
  final int id;

  DetailMovie({Key key, @required this.title, @required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DetailMovieScreen(
        title: title,
        id: id,
      ),
    );
  }
}

class DetailMovieScreen extends StatefulWidget {
  final String title;
  final int id;

  DetailMovieScreen({Key key, this.title, this.id}) : super(key: key);

  @override
  State createState() => _DetailMovieScreen();
}

class _DetailMovieScreen extends State<DetailMovieScreen> {
  final double appBarHeight = 256.0;

  AppBarBehavior appBarBehavior = AppBarBehavior.pinned;

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<Movie>(
      future: Api.getMovie(widget.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: appBarHeight,
                  pinned: appBarBehavior == AppBarBehavior.pinned,
                  floating: appBarBehavior == AppBarBehavior.floating ||
                      appBarBehavior == AppBarBehavior.snapping,
                  snap: appBarBehavior == AppBarBehavior.snapping,
                  actions: <Widget>[
                    PopupMenuButton<AppBarBehavior>(
                      onSelected: (AppBarBehavior value) {
                        setState(() {
                          appBarBehavior = value;
                        });
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuItem<AppBarBehavior>>[
                            const PopupMenuItem<AppBarBehavior>(
                              value: AppBarBehavior.normal,
                              child: Text('App bar scrolls away'),
                            ),
                            const PopupMenuItem<AppBarBehavior>(
                              value: AppBarBehavior.pinned,
                              child: Text('App bar stays put'),
                            ),
                            const PopupMenuItem<AppBarBehavior>(
                              value: AppBarBehavior.floating,
                              child: Text('App bar floats'),
                            ),
                            const PopupMenuItem<AppBarBehavior>(
                              value: AppBarBehavior.snapping,
                              child: Text('App bar snaps'),
                            ),
                          ],
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    title: Container(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                    centerTitle: true,
                    background: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: Utils.getLinkImageBigger(
                              snapshot.data.backdropPath),
                          placeholder: (context, url) => Container(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.0,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blueAccent),
                                ),
                                width: 50,
                                height: 50,
                              ),
                          fit: BoxFit.cover,
                        ),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.0, -1.0),
                              end: Alignment(0.0, -0.4),
                              colors: <Color>[
                                Color(0x60000000),
                                Color(0x00000000)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      AnnotatedRegion<SystemUiOverlayStyle>(
                          value: SystemUiOverlayStyle.dark,
                          child: Container(
                            child: Column(
                              children: <Widget>[

                              ],
                            ),
                            padding: EdgeInsets.all(16.0),
                          )),
                    ],
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}

enum AppBarBehavior { normal, pinned, floating, snapping }

class CollapseAppBar extends StatelessWidget {
  final String title;

  const CollapseAppBar({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(title),
    );
  }
}
