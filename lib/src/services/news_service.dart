import 'package:flutter/widgets.dart';
import 'package:flutter_news_app/src/model/news_models.dart';
import 'package:http/http.dart' as http;

class NewsService with ChangeNotifier {
  final _BASE_URL = "https://newsapi.org/v2";
  final _API_KEY = "3b4ce0fe9d5049119dc3806aa43c706b";

  List<Article> headlines = [];

  NewsService() {}

  getTopHeadlines() async {
    final url = "$_BASE_URL/top-headlines?apiKey=$_API_KEY&country=us";
    final urlAsUri = Uri.parse(url);
    final resp = await http.get(urlAsUri);

    final newsResponse = newsResponseFromJson(resp.body);

    if ((newsResponse.articles?.length ?? 0) > 0) {
      this.headlines.addAll(newsResponse.articles!);
      notifyListeners();
    }
  }
}
