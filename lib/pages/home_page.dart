import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ia/services/api_service.dart';
import 'package:ia/model/article_model.dart';
import 'package:ia/components/custom_list_tile.dart';

void main() {
  runApp(MyApp());
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class _HomePageState extends State<HomePage> {
  ApiService client = ApiService();
  Icon visibleIcon = Icon(Icons.search);
  Widget searchBar = Text('News Compiled',
    style: GoogleFonts.bebasNeue(
      fontSize: 45,
      color: Colors.white,
    ),);

  List<Article> get articles => null;
  set articles(List<Article> articles) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: searchBar, actions: <Widget>[
        IconButton(
          icon: visibleIcon,
          onPressed: () {
            setState(() {
              if (this.visibleIcon.icon == Icons.search) {
                this.visibleIcon = Icon(Icons.cancel);
                this.searchBar = TextField(
                  onSubmitted: (var query) {
                    search(query);
                  },
                  textInputAction: TextInputAction.search,
                  style: GoogleFonts.bebasNeue(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                );
              } else {
                setState(() {
                  this.visibleIcon = Icon(Icons.search);
                  this.searchBar = Text('News Compiled',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 45,
                      color: Colors.white,
                    ),);
                });
              }
            });
          },
        ),
      ]),
      body: FutureBuilder(
        future: client.getArticle(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData) {
            List<Article> articles = snapshot.data;
            return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) =>
                    customListTile(articles[index], context));
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          );
        },
      ),
    );
  }

  Future search(query) async {
    client.query = query;
    List<Article> articlesFound = await client.getArticle();
    setState(() {
      articles = articlesFound;
    });
  }
  }