import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'dart:convert' as json;
import 'package:http/http.dart' as http;
import 'serializers.dart';

part 'article_parsing.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {

  static Serializer<Article> get serializer => _$articleSerializer;
  int get id;
  @nullable
  bool get deleted;
  String get type;
  String get by;
  int get time;
  @nullable
  String get text;
  @nullable
  bool get dead;
  @nullable
  int get parent;
  @nullable
  int get poll;
  BuiltList<int> get kids;
  @nullable
  String get url;
  @nullable
  int get score;
  String get title;
  BuiltList<int> get parts;
  @nullable
  int get descendants;

  Article._();
  factory Article([updates(ArticleBuilder b)]) = _$Article;
}

Future<List> parseTopStoriesFuture() async{
//  final parsed = json.jsonDecode("https://hacker-news.firebaseio.com/v0/topstories.json");
//  final listOfInts = List<int>.from(parsed);
//  return listOfInts;
  String apiUrl ="https://hacker-news.firebaseio.com/v0/topstories.json";
  http.Response response = await http.get(apiUrl);
  var data = json.jsonDecode(response.body);
   print(data);
  return data;
}

Future<List> parseTopStories(String jsonStr) async{
  final parsed = json.jsonDecode(jsonStr);
  final listOfInts = List<int>.from(parsed);
  return listOfInts;
}

Future<Article> parseArticle(String jsonStr) async{
  final parsed = json.jsonDecode(jsonStr);
  Article article = standardSerializers.deserializeWith(Article.serializer, parsed);
  return article;
}
List<int> parseTopStoriesTestCase(String jsonStr) {
  final parsed = json.jsonDecode(jsonStr);
  final listOfInts = List<int>.from(parsed);
  return listOfInts;
}

Article parseArticleTestCase(String jsonStr) {
  final parsed = json.jsonDecode(jsonStr);
  Article article = standardSerializers.deserializeWith(Article.serializer, parsed);
  return article;
}