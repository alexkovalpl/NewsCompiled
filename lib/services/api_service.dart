import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ia/model/article_model.dart';
import 'package:ia/pages/home_page.dart';

class ApiService extends HomePage {
  final endPointUrl = "newsapi.org";
  final client = http.Client();

  var query;

  Future<List<Article>> getArticle() async {
    final queryParameters = {
      'domains': 'foreignpolicy.com, foreignaffairs.com, economist.com, theconversion.com',
      'sortBy': 'publishedAt',
      'q': '$query',
      'apiKey': 'dff5d783b11e4bd18c11840864c2f32e'
    };

    final uri = Uri.https(endPointUrl, '/v2/everything', queryParameters);
    final response = await client.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> body = json['articles'];
    List<Article> articles =
        body.map((dynamic item) => Article.fromJson(item)).toList();
    return articles;
  }
}
