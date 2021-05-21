import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class TabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavigationProvider(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _BottomNavigationBar(),
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<_NavigationProvider>(context);

    return BottomNavigationBar(
      currentIndex: navigationProvider.currentPage,
      onTap: (int tabSelected) => navigationProvider.currentPage = tabSelected,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: "For You"),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: "Headers"),
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<_NavigationProvider>(context);

    return PageView(
      controller: navigationProvider.pageController,
      physics: BouncingScrollPhysics(),
      onPageChanged: (int newCurrentPage) {
        navigationProvider.currentPage = newCurrentPage;
      },
      children: [
        Container(color: Colors.red),
        Container(color: Colors.cyan),
      ],
    );
  }
}

class _NavigationProvider extends ChangeNotifier {
  int _currentPage = 0;
  final _pageController = new PageController();

  int get currentPage => this._currentPage;

  set currentPage(int newCurrentPage) {
    this._currentPage = newCurrentPage;

    _pageController.animateToPage(
      newCurrentPage,
      duration: Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );

    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
