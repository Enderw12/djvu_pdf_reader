import 'package:docx_pdf_reader/screens/document_picker_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  /// this is a simple welcome screen
  static const route = '/';
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // FlatButton отлично подходит для вызова какого либо действия.
        // Может содержать метод/функцию которую нужно вызвать, Иконку и быть подписан.
        child: FlatButton.icon(
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(DocumentPickerScreen.route),
            icon: Icon(Icons.input),
            label: Text('Нажми меня чтобы перейти к выбору документа')),
      ),
    );
  }
}
