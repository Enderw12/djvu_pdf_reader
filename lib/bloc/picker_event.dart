part of 'picker_bloc.dart';

@immutable
abstract class PickerEvent {}

class PickPdfDocument extends PickerEvent {
  /// вызов окна выбора файла расширения [pdf]
  PickPdfDocument();
}

class PickDocDocument extends PickerEvent {
  /// вызов окна выбора файла расширения [doc] или [docx]
  PickDocDocument();
}
