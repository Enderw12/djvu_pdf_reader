part of 'picker_bloc.dart';

@immutable
abstract class PickerEvent {}

class PickDocument extends PickerEvent {
  /// вызов окна выбора документа
  PickDocument();
}
