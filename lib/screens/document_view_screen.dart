import 'package:flutter/material.dart';

class DocumentViewScreen extends StatelessWidget {
  static const route = '/document_view_screen';
  const DocumentViewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('страница просмотра документа')),
      ),
    );
  }
}
