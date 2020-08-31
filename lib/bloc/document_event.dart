part of 'document_bloc.dart';

@immutable
abstract class DocumentEvent {
  const DocumentEvent();
}

class OpenDocument extends DocumentEvent {
  final Map data;
  const OpenDocument(this.data);
}
