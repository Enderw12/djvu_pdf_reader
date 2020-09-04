part of 'document_bloc.dart';

@immutable
abstract class DocumentEvent {
  /// базовый класс для всех возможных событий относящихся к данному блоку   
  const DocumentEvent();
}

class OpenDocument extends DocumentEvent {
  /// данный ивент (он же событие) может содержать в себе любые данные в ссловаре (Map) data, в самом блоке получаем доступ по ключу.
  final Map data;
  const OpenDocument(this.data);
}
