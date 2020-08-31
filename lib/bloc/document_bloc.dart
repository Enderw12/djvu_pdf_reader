import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  DocumentBloc() : super(DocumentInitial());

  @override
  Stream<DocumentState> mapEventToState(
    DocumentEvent event,
  ) async* {
    if (event is OpenDocument) {
      final data = {
        'filePath': event.data['filePath'],
        'fileName': event.data['fileName'],
      };
      yield DocumentLoaded(data);
    }
  }
}
