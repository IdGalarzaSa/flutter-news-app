import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tab page'),
      ),
      body: Center(
        child: Text('Tab page'),
      ),
    );
  }
}
