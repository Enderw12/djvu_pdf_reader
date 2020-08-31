import 'dart:async';
import 'package:path/path.dart' as path;

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';

part 'picker_event.dart';
part 'picker_state.dart';

class PickerBloc extends Bloc<PickerEvent, PickerState> {
  PickerBloc() : super(PickerInitial());

  @override
  Stream<PickerState> mapEventToState(
    PickerEvent event,
  ) async* {
    // обрабатываем событие "выбор PDF-документа"
    if (event is PickDocument) {
      yield PickerLoading();
      final String filePath = await FilePicker.getFilePath();
      if (filePath != null) {
        if (path.extension(filePath).endsWith('.doc') ||
            path.extension(filePath).endsWith('.docx') ||
            path.extension(filePath).endsWith('.pdf')) {
          final String fileName = path.basenameWithoutExtension(filePath);
          bool isPdf = path.extension(filePath).endsWith('.pdf');
          yield PickerLoaded({
            'filePath': filePath,
            'fileName': fileName,
            'isPdf': isPdf,
          });
        } else {
          yield PickerError(
              'Неверный формат. Допустимы только doc, docx, pdf форматы.');
        }
      } else {
        yield PickerError('Вы ничего не выбрали!');
      }
    }
  }
}
