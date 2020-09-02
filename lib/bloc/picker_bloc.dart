import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'picker_event.dart';
part 'picker_state.dart';

class PickerBloc extends Bloc<PickerEvent, PickerState> {
  PickerBloc() : super(PickerInitial());

  Future<File> convert(filePath, fileName) async {
    final dio = Dio();
    FormData formData = FormData.fromMap({
      "file":
          await MultipartFile.fromFile(filePath, filename: '$fileName.djvu'),
    });
    try {
      final response = await dio.post("http://46.250.117.61:5000/convert",
          data: formData, options: Options(responseType: ResponseType.bytes));
      final data = response.data;
      // print(response.data);
      File pdf = await _localFile(fileName);
      await pdf.writeAsBytes(data);
      return pdf;
    } catch (e) {
      return null;
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName.pdf');
  }

  @override
  Stream<PickerState> mapEventToState(
    PickerEvent event,
  ) async* {
    // обрабатываем событие "выбор PDF-документа"
    if (event is PickDocument) {
      yield PickerLoading();
      String filePath = await FilePicker.getFilePath();
      if (filePath != null) {
        if (path.extension(filePath).endsWith('.djvu') ||
            path.extension(filePath).endsWith('.pdf')) {
          String fileName = path.basenameWithoutExtension(filePath);
          bool isPdf = path.extension(filePath).endsWith('.pdf');
          if (!isPdf) {
            File file = await convert(filePath, fileName);
            if (file == null) {
              yield PickerError("Ошибка на сервере. Попробуйте снова");
            } else {
              filePath = file.path;
              fileName = path.basenameWithoutExtension(filePath);
            }
          }
          yield PickerLoaded({
            'filePath': filePath,
            'fileName': fileName,
            'isPdf': isPdf,
          });
        } else {
          yield PickerError(
              'Неверный формат. Допустимы только djvu, pdf форматы.');
        }
      } else {
        yield PickerError('Вы ничего не выбрали!');
      }
    }
  }
}
