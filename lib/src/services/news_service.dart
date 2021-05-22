import 'package:flutter/widgets.dart';
import 'package:flutter_news_app/src/model/cateogory_model.dart';
import 'package:flutter_news_app/src/model/news_models.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class NewsService with ChangeNotifier {
  final _BASE_URL = "https://newsapi.org/v2";
  final _API_KEY = "10a3113ed79d40f5a42aeba94dda1df5";

  // Properties
  List<Article> headlines = [];
  List<CategoryModel> categoryList = [
    CategoryModel(FontAwesomeIcons.building, "business"),
    CategoryModel(FontAwesomeIcons.tv, "entertainment"),
    CategoryModel(FontAwesomeIcons.addressCard, "general"),
    CategoryModel(FontAwesomeIcons.headSideVirus, "health"),
    CategoryModel(FontAwesomeIcons.vials, "science"),
    CategoryModel(FontAwesomeIcons.futbol, "sports"),
    CategoryModel(FontAwesomeIcons.memory, "technology"),
  ];
  String _currentCategory = "business";
  Map<String, List<Article>> categoryArticles = new Map();

  // Constructor
  NewsService() {
    getTopHeadlines();
    categoryList
        .forEach((category) => categoryArticles[category.categoryName] = []);
    getHeadlinesByCategory(this.currentCategory);
  }

  // _currentCategory
  String get currentCategory => this._currentCategory;

  set currentCategory(String newCategorySelected) {
    this._currentCategory = newCategorySelected;
    getHeadlinesByCategory(newCategorySelected);
    notifyListeners();
  }

  get selectedCategoryArticles => this.categoryArticles[this.currentCategory];

  // headlines
  getTopHeadlines() async {
    final url = "$_BASE_URL/top-headlines?apiKey=$_API_KEY&country=us";
    final urlAsUri = Uri.parse(url);
    final resp = await http.get(urlAsUri);

    print("-----> Request made");

    final newsResponse = newsResponseFromJson(resp.body);

    if ((newsResponse.articles?.length ?? 0) > 0) {
      this.headlines.addAll(newsResponse.articles!);
      notifyListeners();
    }
  }

  getHeadlinesByCategory(String newCategorySelected) async {
    if ((categoryArticles[newCategorySelected]?.length ?? 0) > 0) {
      return categoryArticles[newCategorySelected];
    }

    final url =
        "$_BASE_URL/top-headlines?apiKey=$_API_KEY&country=us&category=$newCategorySelected";
    final urlAsUri = Uri.parse(url);
    final resp = await http.get(urlAsUri);

    print("-----> Request made2");

    final newsResponse = newsResponseFromJson(resp.body);

    categoryArticles[newCategorySelected]?.addAll(newsResponse.articles ?? []);

    notifyListeners();
  }
}
