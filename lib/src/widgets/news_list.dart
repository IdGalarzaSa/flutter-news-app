import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/model/news_models.dart';
import 'package:flutter_news_app/src/theme/theme.dart';

class NewsList extends StatelessWidget {
  List<Article> articleList;

  NewsList(this.articleList);

  @override
  Widget build(BuildContext context) {
    return articleList.length == 0
        ? Center(
            child: CircularProgressIndicator(
              color: myAppTheme.accentColor,
            ),
          )
        : Scrollbar(
            child: ListView.builder(
              itemCount: articleList.length,
              itemBuilder: (BuildContext context, int index) {
                return _New(articleList[index], index);
              },
            ),
          );
  }
}

class _New extends StatelessWidget {
  final Article article;
  final int articleIndex;

  _New(this.article, this.articleIndex);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                _TopBarCard(article, articleIndex),
                _TitleCard(article),
                _ImageCard(article),
                _BodyCard(article),
                Divider(thickness: 2, height: 10),
                _Buttons(article)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBarCard extends StatelessWidget {
  final Article article;
  final int articleIndex;
  _TopBarCard(this.article, this.articleIndex);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 5),
          child: Text(
            "${articleIndex + 1}. ",
            style: TextStyle(color: myAppTheme.accentColor),
          ),
        ),
        Flexible(child: Text(article.source?.name ?? ""))
      ],
    );
  }
}

class _TitleCard extends StatelessWidget {
  final Article article;

  _TitleCard(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Text(
        article.title ?? "",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _ImageCard extends StatelessWidget {
  final Article article;

  const _ImageCard(this.article);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        bottomRight: Radius.circular(50),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: article.urlToImage != null
            ? FadeInImage(
                placeholder: AssetImage("assets/giphy.gif"),
                image: NetworkImage(article.urlToImage!),
              )
            : Image(
                image: AssetImage("assets/no-image.png"),
              ),
      ),
    );
  }
}

class _BodyCard extends StatelessWidget {
  final Article article;

  _BodyCard(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Text(article.description ?? ""),
    );
  }
}

class _Buttons extends StatelessWidget {
  final Article article;

  _Buttons(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {},
            child: Icon(Icons.star_outline),
            fillColor: myAppTheme.accentColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          SizedBox(
            width: 10,
          ),
          RawMaterialButton(
            onPressed: () {},
            child: Icon(Icons.more),
            fillColor: Colors.blue,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          )
        ],
      ),
    );
  }
}
