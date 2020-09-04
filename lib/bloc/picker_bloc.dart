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
  /// сердце пакета bloc. Данный класс описывает всю полезную работу по преобразованию поступающих ивентов (событий) в состояния 
  
  
  // изначальным состоянием всегда является PickerInitial поэтому его передаём в конструктор супер-класса, который отправляет данный объект в интерфейс
  PickerBloc() : super(PickerInitial()); 

  Future<File> convert(filePath, fileName) async {
    /// данный метод содержит логику обращений к серверу для передачи djvu документа, и загрузки ответа — pdf
    
    // Dio — многофункциональный http-клиент. 
    final dio = Dio();
    
    // формирование "тела" запроса. сюда же прилагается документ для отправки
    FormData formData = FormData.fromMap({
      "file":
          await MultipartFile.fromFile(filePath, filename: '$fileName.djvu'),
    });
    try {
      // 
      final response = await dio.post("http://46.250.117.61:5000/convert",
          data: formData, options: Options(responseType: ResponseType.bytes));
      final data = response.data;
      // print(response.data);
      File pdf = await _localFile(fileName);
      await pdf.writeAsBytes(data);
      return pdf;
    } catch (e) {
      // поскольку наш метод не может не вернуть ничего (void), возвращаем null
      return null;
      
    }
  }

  Future<String> get _localPath async {
    // здесь получаем путь к директории приложения
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    // здесь создаём пустой файл с нужным названием в директории приложения
    final path = await _localPath;
    return File('$path/$fileName.pdf');
  }

  @override
  Stream<PickerState> mapEventToState(
    PickerEvent event,
  ) async* {
    // обрабатываем событие "выбор PDF-документа"
    if (event is PickDocument) {
      // сразу отправляем на экран DocumentPicker (document_picker.dart) состояние сигнализирующее о том что в данный момент происходит загрузка документа
      yield PickerLoading();
      // используем пакет FilePicker для вызова нативного "проводника" операционной системы и выбора файла
      String filePath = await FilePicker.getFilePath();
      if (filePath != null) {
        // если файл был выбран, то путь к нему не будет null-полем
        
        // проверяем расширение выбранного файла на соответствие допустимым форматам
        if (path.extension(filePath).endsWith('.djvu') ||
            path.extension(filePath).endsWith('.pdf')) {
          
          String fileName = path.basenameWithoutExtension(filePath);
          bool isPdf = path.extension(filePath).endsWith('.pdf');
          if (!isPdf) {
            // вызываем метод выполняющий запрос к серверу. await — как и ранее, означает что код должен исполняться синхронно
            // несмотря на асинхронность вызванной функции, завершения её выполнения нужно дождаться.
            File file = await convert(filePath, fileName);
            if (file == null) {
              // метод convert в случае неудачи вощвращает null, что не является подходящим содержанием для документа. Возвращаем состояние с текстом ошибки в нём.
              yield PickerError("Ошибка на сервере. Попробуйте снова");
            } else {
              // в случае успешного прохождения всех проверок — файл правильного формата, не пустой, обращение к серверу не завершилось ошибкой..
              // сохраняем в переменные имя файла для отображения в интерфейсе читалки и путь к нему.
              filePath = file.path;
              fileName = path.basenameWithoutExtension(filePath);
            }
          }
          // создаём и передаём в UI состояние со всеми данными
          yield PickerLoaded({
            'filePath': filePath,
            'fileName': fileName,
            'isPdf': isPdf,
          });
        } else {
          // альтернативный код при проверке на формат файла. Сообщение об ошибке говорит само за себя
          yield PickerError(
              'Неверный формат. Допустимы только djvu, pdf форматы.');
        }
      } else {
        // если файл не выбрали, то он является null объектом, не имеет пути, значит пользователь ничего не выбрал для просмотра — сообщим же ему об этом.
        yield PickerError('Вы ничего не выбрали!');
      }
    }
  }
}
