import 'package:djvu_pdf_reader/bloc/document_bloc.dart';
import 'package:djvu_pdf_reader/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

// import 'package:flutter_filereader/flutter_filereader.dart';

class DocumentViewScreen extends StatelessWidget {
  static const route = '/document_view_screen';
  const DocumentViewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      builder: (context, state) {
        if (state is DocumentLoaded) {
          return DocumentLoadedWidget(state: state);
        } else if (state is DocumentLoading) {
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
              child: CircularProgressIndicator(),
            ),
          );
        } else {
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
