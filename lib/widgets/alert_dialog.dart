import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> showExitDialog(ctx) async {
  return showDialog<void>(
    context: ctx,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Требуется подтверждение!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Уверены что хотите выйти из приложения?'),
            ],
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              child: Text('Выход'),
              onPressed: () => SystemNavigator.pop(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}
