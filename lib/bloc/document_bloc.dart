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
    if (event is OpenDocument)
      final data = {
        'filePath': event.data['filePath'],
        'fileName': event.data['fileName'],
      };
      // Поскольку в "блоке" выбора файла совершены все необходимые проверки, тут возвращается единственное возможное состояние этого экрана, содержит имя документа и путь к нему.
      // могут быть добавлены и другие обработки ивентов и преобразования в состояния в последующих if-else конструкциях.
      yield DocumentLoaded(data);
    }
  }
}
