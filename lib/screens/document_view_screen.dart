import 'package:djvu_pdf_reader/bloc/document_bloc.dart';
import 'package:djvu_pdf_reader/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';


class DocumentViewScreen extends StatelessWidget {
  /// этот виджет не делает ничего кроме отображения документа. Или сообщения об ошибке, в случае если в логике bloc допущена ошибка.
  static const route = '/document_view_screen';
  const DocumentViewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      // BlocBuilder обеспечивает доступ к состояниям базового класса DocumentState генерируемым объектом класса DocumentBloc 
      builder: (context, state) {
        if (state is DocumentLoaded) {
          // если состояние "загруженного документа", то отображается виджет способный отобразить его (из пакета flutter_full_pdf_viewer)
          return DocumentLoadedWidget(state: state);
        } else if (state is DocumentLoading) {
          // если состояние "загрузка" то показываем экран с вращающимся иникатором загрузки 
          return Scaffold(
            appBar: AppBar(
              title: Text('Идёт загрузка...'),
              actions: [
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () => showExitDialog(context),
                )
              ],
            ),
            body: Center(
              // вращающийся индикатор загрузки
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          // если предыдущие сценарии не подошли, отображается экран с сообщением об ошибке
          return Scaffold(
            appBar: AppBar(
              title: Text('Ошибка'),
              actions: [
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () => showExitDialog(context),
                )
              ],
            ),
            body: Center(
              child: Text(
                "Произошла непредвиденная ошибка!",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class DocumentLoadedWidget extends StatelessWidget {
  const DocumentLoadedWidget({
    this.state,
    Key key,
  }) : super(key: key);
  final DocumentLoaded state;

  @override
  Widget build(BuildContext context) {
    // тот самый виджет способный отображать содержимое PDF-документов
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text('${state.data['fileName']}'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => showExitDialog(context),
          )
        ],
      ),
      path: state.data['filePath'],
    );
  }
}
