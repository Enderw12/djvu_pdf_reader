import 'package:docx_pdf_reader/screens/document_picker_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  /// this is a simple welcome screen
  static const route = '/';
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // добавляет отступы вокруг элемента для избежания наложения на элементы интерфейса операционной системы.
        child: Container(
          margin: EdgeInsets.all(
              1), // внешний отступ. аналог padding который задаёт внутренний отступ
          decoration: BoxDecoration(
            // декорации контейнера. например граница border
            border: Border.all(
              width: 4,
              color: Colors.black,
            ),
          ),
          // FlatButton отлично подходит для вызова какого либо действия.
          // Может содержать метод/функцию которую нужно вызвать, Иконку и быть подписан.
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, // выравнивание по главной оси. для колонки — вертикальное
            crossAxisAlignment: CrossAxisAlignment
                .center, // выравнивание по вторичной/поперечной оси.
            children: [
              Expanded(
                  child:
                      Container()), // аналог контейнера, но "жадный" к пространству — пытается занять всё доступное пространство. Можно использовать для выравнивания других элементов
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width *
                        0.6), // ограничение размеров по нижней и верхней границе. Требует точного указания размеров. Эффективен в сочетании с MediQuery-данными
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Приложение для просмотра doc- и pdf-файлов",
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              InkWell(
                // базовый виджет для "подключения" простых жестов к любому виджету. в данном случае нажатие
                onTap: () => Navigator.of(context)
                    .pushReplacementNamed(DocumentPickerScreen.route),
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 25,
                    ),
                    child: Text("Перейти"),
                  ),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
