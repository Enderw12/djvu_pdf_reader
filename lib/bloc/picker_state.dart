part of 'picker_bloc.dart';

@immutable
abstract class PickerState {
  const PickerState();
}

class PickerInitial extends PickerState {
  const PickerInitial();
}

class PickerLoading extends PickerState {
  const PickerLoading();
}

class PickerLoaded extends PickerState {
  const PickerLoaded(this.data);

  final Map data;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is PickerLoaded && o.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}

class PickerError extends PickerState {
  const PickerError(this.message);
  final String message;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is PickerError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
