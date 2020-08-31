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
    if (event is PickPdfDocument) {
      try {
        yield PickerLoading();
        final String filePath = await FilePicker.getFilePath(
            type: FileType.custom, allowedExtensions: ['pdf']);
        final String fileName = path.basenameWithoutExtension(filePath);
        yield PickerLoaded({'filePath': filePath, 'fileName': fileName});
      } catch (_) {
        yield PickerError('Возникла ошибка, попробуйте снова.');
      }
    }

    // обрабатываем событие "выбор Word-документа"
    if (event is PickDocDocument) {
      try {
        yield PickerLoading();
        String filePath = await FilePicker.getFilePath(
            type: FileType.custom, allowedExtensions: ['doc', 'docx']);
        final String fileName = path.basenameWithoutExtension(filePath);
        yield PickerLoaded({'filePath': filePath, 'fileName': fileName});
      } catch (_) {
        yield PickerError('Возникла ошибка, попробуйте снова.');
      }
    }
  }
}
