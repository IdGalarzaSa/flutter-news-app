import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/services/news_service.dart';
import 'package:flutter_news_app/src/theme/theme.dart';
import 'package:flutter_news_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final headlines = Provider.of<NewsService>(context).headlines;

    return Scaffold(
      body: SafeArea(
        child: Container(
            child: headlines.length == 0
                ? Center(
                    child: CircularProgressIndicator(
                        color: myAppTheme.accentColor),
                  )
                : NewsList(headlines)),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
