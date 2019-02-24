import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_walkthrough/src/article_parsing.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:progress_indicators/progress_indicators.dart';


class HackerNews extends StatefulWidget {
  HackerNews({Key key, this.title}):super(key:key);
  final String title;
  @override  _HackerNewsState createState() => _HackerNewsState();
}
class _HackerNewsState extends State<HackerNews> {

  Future<Article> _getArticle(int id) async{
    final storyUrl = "https://hacker-news.firebaseio.com/v0/item/$id.json";
    final storyRes = await http.get(storyUrl);
    if(storyRes.statusCode == 200){
      return parseArticle(storyRes.body);
    }
    return null;
  }
  Widget helper(List future){
    return ListView(
          shrinkWrap: true,
          primary: false,
          children: future.map((i)=>
            FutureBuilder<Article>(
              future: _getArticle(i),
              builder: (BuildContext context, AsyncSnapshot<Article> snapShot){
                if(snapShot.connectionState == ConnectionState.done){
                  return _buildItem(snapShot.data);
                }return Center(
                    child: FadingText('...')
                );
              },
            )).toList());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Hacker News",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      )),
                  background: Image.asset('assets/images/newspaper-image.jpg',
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
          body: 
          FutureBuilder(
              future: parseTopStoriesFuture(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: FadingText('Loading...')
                  );
                  return helper(snapshot.data);
              }),
      ),
    );
  }

  Widget _buildItem(Article article){
    var format = DateFormat.yMMMd("en_US").add_jm();
    var _date = format.format(
        DateTime.fromMicrosecondsSinceEpoch(
            article.time * 1000,
            isUtc: true) ?? ['null']);
    return Padding(
      key: Key(article.title),
      padding: const EdgeInsets.all(15.0),
      child: ExpansionTile(title: Text(article.title, style:  TextStyle(fontSize : 24.0)),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(_date) ?? ['null'],
                IconButton(
                  icon: Icon(Icons.launch),
                  onPressed: () async{
                      if(await canLaunch(article.url)){
                        launch(article.url);
                      }
                  }
                )
              ],
            )
        ],
      ),
    );
  }
}