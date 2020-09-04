import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> showExitDialog(ctx) async {
  /// этот диалог вынесен в отдельный файл для демонстрации возможностей организации структуры приложения.
  
  return showDialog<void>(
    context: ctx,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        // отображает диалоговое окно поверх остальных объектов на экране. 
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
              // SystemNavigator.pop() отдаёт команду на завершение работы приложения
              onPressed: () => SystemNavigator.pop(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              child: Text('Отмена'),
              onPressed: () {
                // данный метод "закрывает" тот экран с которого он вызван. В данном случае таковым является виджет класса AlertDialog
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}
