import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/model/cateogory_model.dart';
import 'package:flutter_news_app/src/services/news_service.dart';
import 'package:flutter_news_app/src/theme/theme.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatefulWidget {
  @override
  _Tab2PageState createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _CategoryList()),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryList = Provider.of<NewsService>(context).categoryList;

    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: categoryList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: _CategoryButton(category: categoryList[index]),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final CategoryModel category;

  const _CategoryButton({required this.category});

  @override
  Widget build(BuildContext context) {
    final cname = category.categoryName;

    return GestureDetector(
      onTap: () {
        final newsProvider = Provider.of<NewsService>(context, listen: false);
        newsProvider.currentCategory = category.categoryName;
      },
      child: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            _CircleIcon(category: category),
            SizedBox(height: 8),
            Text("${cname[0].toUpperCase()}${cname.substring(1)}")
          ],
        ),
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  final CategoryModel category;

  const _CircleIcon({required this.category});

  @override
  Widget build(BuildContext context) {
    final categorySelected =
        Provider.of<NewsService>(context, listen: false).currentCategory;
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(
        category.icon,
        color: categorySelected == category.categoryName
            ? myAppTheme.accentColor
            : Colors.black38,
      ),
    );
  }
}
