import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/document_bloc.dart';
import '../bloc/picker_bloc.dart';
import '../widgets/alert_dialog.dart';
import 'document_view_screen.dart';

class DocumentPickerScreen extends StatelessWidget {
  /// [DocumentPickerScreen] экран отвечает за выбор документа который нужно будет открыть.
  /// экран приложения, страница приложения — одно и то же, является основным объектом навигации в приложении.
  // route — константная переменная содержащая в себе адрес экрана
  // указание пути через константу уменьшенает вероятность ошибки при указании пути в routes в main.dart и в процессе рефакторинга проекта.
  static const route = '/document_picker_screen';
  const DocumentPickerScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // через объект PickerBloc виджеты могут получить возможность вызывать события (picker_event.dart)
    final PickerBloc pickerBloc = BlocProvider.of<PickerBloc>(context);

    // Scaffold — основной виджет необходимый для нормальной работы.
    // Его отсутствие сразу бросается в глаза — фон приложения станет чёрным, а другие виджеты будут вести себя не так как задумывалось.
    return Scaffold(
      // AppBar — верхняя панель на экране приложения. Как правило содержит заголовок, элементы навигации и несколько кнопок.
      appBar: AppBar(
        title: Center(child: Text('Экран выбора документа')),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => showExitDialog(context),
          )
        ],
      ),
      // Container — один из базовых виджетов используемых для разметки (вертски).
      // Сам по себе невидим и ничего не делает, но позволяет структурировать содержимое на экране и влиять на его характеристики.
      body: BlocConsumer<PickerBloc, PickerState>(listener: (context, state) {
// тут выводится сообщение об ошибке.
// функционал BlocListener гарантирует что это сообщение будет показано максимум единожды на каждое новое состояние
        if (state is PickerError)
          return Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            duration: Duration(
              milliseconds: 2000,
            ),
          ));
      }, builder: (context, state) {
        if (state is PickerInitial) {
          return PickerWidget(pickerBloc: pickerBloc, state: state);
        }
        if (state is PickerLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PickerLoaded) {
          return PickerWidget(pickerBloc: pickerBloc, state: state);
        } else {
          // в случае ошибки PickerError показать интерфейс для выбора другого файла
          return PickerWidget(
            pickerBloc: pickerBloc,
            state: state,
          );
        }
      }),
    );
  }
}

class PickerWidget extends StatelessWidget {
  const PickerWidget({
    Key key,
    @required this.pickerBloc,
    @required this.state,
    this.cardText = 'Документ не выбран',
  }) : super(key: key);
  final PickerState state;
  final PickerBloc pickerBloc;
  final String cardText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: FlatButton.icon(
                color: Colors.indigoAccent[100],
                onPressed: () => pickerBloc.add(PickDocument()),
                icon: Icon(Icons.file_copy),
                label: Text('Выбрать документ')),
          ),
          Expanded(
              child: Center(child: Text('Допустимые форматы: doc, docx, pdf'))),
          ReadButtonWidget(state: state)
        ],
      ),
    );
  }
}

class ReadButtonWidget extends StatelessWidget {
  const ReadButtonWidget({
    Key key,
    @required this.state,
  }) : super(key: key);

  final PickerState state;

  @override
  Widget build(BuildContext context) {
    String label = 'Документ не выбран';
    if (state is PickerLoaded) {
      final PickerLoaded currentState = state;
      final bool isPdf = currentState.data['isPdf'];
      label = '${currentState.data['fileName']}';

      final RichText richTextLabel = RichText(
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
        text: TextSpan(
          text: 'Открыть: ',
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
                text: label, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );

      return FlatButton.icon(
        disabledColor: Colors.grey[200],
        color: Colors.indigoAccent[100],
        highlightColor: Colors.cyanAccent[100],
        onPressed: () {
          BlocProvider.of<DocumentBloc>(context).add(OpenDocument({
            'filePath': currentState.data['filePath'],
            'fileName': currentState.data['fileName'],
          }));
          Navigator.of(context).pushNamed(DocumentViewScreen.route);
        },
        icon: Icon(
          isPdf ? Icons.picture_as_pdf : Icons.chrome_reader_mode,
        ),
        label: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.65),
            child: richTextLabel),
      );
    } else {
      return FlatButton.icon(
        disabledColor: Colors.grey[200],
        onPressed: null,
        icon: Icon(
          Icons.error,
          color: Colors.red,
        ),
        label: Text(label),
      );
    }
  }
}
