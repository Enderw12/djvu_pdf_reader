part of 'document_bloc.dart';

@immutable
abstract class DocumentState {
  const DocumentState();
}

class DocumentInitial extends DocumentState {
  const DocumentInitial();
}

class DocumentLoading extends DocumentState {
  const DocumentLoading();
}

class DocumentLoaded extends DocumentState {
  const DocumentLoaded(this.document);
  final String document;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is DocumentLoaded && o.document == document;
  }

  @override
  int get hashCode => document.hashCode;
}

class DocumentError extends DocumentState {
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
