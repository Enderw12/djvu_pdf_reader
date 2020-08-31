import 'package:docx_pdf_reader/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_filereader/flutter_filereader.dart';

class DocumentViewScreen extends StatelessWidget {
  static const route = '/document_view_screen';
  const DocumentViewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      builder: (context, state) {
        if (state is DocumentLoaded) {
          return DocumentLoadedWidget(state: state);
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
    return Scaffold(
      appBar: AppBar(
        title: Text('${state.data['fileName']}'),
      ),
      body: Container(
        child: Center(
            child: FileReaderView(
          filePath: state.data['filePath'],
        )),
      ),
    );
  }
}
