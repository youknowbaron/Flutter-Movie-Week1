import 'package:flutter/material.dart';
import 'package:movie_week1/movie.dart';
import 'api.dart';

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
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
//      body: CustomScrollView(
//        slivers: <Widget>[
//          SliverToBoxAdapter(child: SizedBox(height: 12)),
//          new FutureBuilder<NowPlaying>(
//            future: Api.getNowPlaying(),
//            builder: (context, snapshot) {
//              if (snapshot.hasData) {
//                return SliverList(
//                  delegate: SliverChildBuilderDelegate((context, index) =>
//                      ListItem(snapshot.data.results[index])),
//                );
//              } else if (snapshot.hasError) {
//                return Text(snapshot.error.toString());
//              }
//              return CircularProgressIndicator();
//            },
//          ),
//          Image.network('https://picsum.photos/250?image=9')
//        ],
//      ),
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
                                horizontal: 16, vertical: 8),
                            itemBuilder: (context, index) =>
                                buildItem(
                                    context, snapshot.data.results[index]),
                            itemCount: snapshot.data.results.length,
                          );
                        }
                      }
                  )
              )
            ],
          ),
          onWillPop: null),
    );
  }

  Widget buildItem(BuildContext context, Movie movie) {
    return Container(
      child: FlatButton(
          onPressed: null,
          child: Row(
            children: <Widget>[
              Text(
                movie.title,
                style: Theme
                    .of(context)
                    .textTheme
                    .title,
                maxLines: 2,
              )
            ],
          )),
    );
  }
}

class ListItem extends StatelessWidget {
  final Movie movie;

  ListItem(this.movie, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: <Widget>[
          Text(
            movie.title,
            style: Theme
                .of(context)
                .textTheme
                .title,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
