import 'package:flutter/material.dart';

class DocumentPickerScreen extends StatelessWidget {
  /// [DocumentPickerScreen] экран отвечает за выбор документа который нужно будет открыть.
  /// экран приложения, страница приложения — одно и то же, является основным объектом навигации в приложении.
  // route — константная переменная содержащая в себе адрес экрана
  // указание пути через константу уменьшенает вероятность ошибки при указании пути в routes в main.dart и в процессе рефакторинга проекта.
  static const route = '/document_picker_screen';
  const DocumentPickerScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Scaffold — основной виджет необходимый для нормальной работы.
    // Его отсутствие сразу бросается в глаза — фон приложения станет чёрным, а другие виджеты будут вести себя не так как задумывалось.
    return Scaffold(
      // AppBar — верхняя панель на экране приложения. Как правило содержит заголовок, элементы навигации и несколько кнопок.
      appBar: AppBar(
        title: Text('AppBar title'),
      ),
      // Container — один из базовых виджетов используемых для разметки (вертски).
      // Сам по себе невидим и ничего не делает, но позволяет структурировать содержимое на экране и влиять на его характеристики.
      body: Container(
        child: Center(child: Text('DOCUMENT PICKER SCREEN')),
      ),
    );
  }
}
