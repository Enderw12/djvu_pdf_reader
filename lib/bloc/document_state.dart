part of 'document_bloc.dart';

@immutable
abstract class DocumentState {
  /// базовый класс для всех возможных состояний. Нужен для "подписки" на stream который "выходит" из блока (bloc)
  const DocumentState();
}

class DocumentInitial extends DocumentState {
  /// данное состояние не несёт полезной информации
  /// самим фактом своего присутствия в результатах работы bloc, объект этого класса объясняет что нужно показать на экране.
  const DocumentInitial();
}

class DocumentLoading extends DocumentState {
  /// аналогично предыдущему
  const DocumentLoading();
}

class DocumentLoaded extends DocumentState {
  /// самый полезный класс. содержит данные для отображения.
  const DocumentLoaded(this.data);
  final Map data;

  // данные методы нужны для сравнения двух состояний, чтобы BlocBuilder, BlocListener и Consumer объекты правильно понимали что состояние изменилось.
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is DocumentLoaded && o.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}

class DocumentError extends DocumentState {
  /// аналогично предыдущему
  const DocumentError(this.message);
  final message;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is DocumentError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
