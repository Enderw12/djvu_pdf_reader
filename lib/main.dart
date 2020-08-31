import 'package:docx_pdf_reader/bloc/document_bloc.dart';
import 'package:docx_pdf_reader/bloc/picker_bloc.dart';
import 'package:docx_pdf_reader/screens/document_picker_screen.dart';
import 'package:docx_pdf_reader/screens/document_view_screen.dart';
import 'package:docx_pdf_reader/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MultiBlocProvider — виджет-обёртка предоставляющий доступ к всем провайдерам из списка providers.
    return MultiBlocProvider(
      providers: [
        BlocProvider<DocumentBloc>(
          create: (context) => DocumentBloc(),
        ),
        BlocProvider<PickerBloc>(
          create: (context) => PickerBloc(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // навигация между экранами приложения
        initialRoute: WelcomeScreen.route,
        routes: {
          // тут мы присваиваем адресу экрана содержащемуся в константном поле route, функцию возвращающую виджет (желаемый экран)
          WelcomeScreen.route: (BuildContext context) => WelcomeScreen(),
          DocumentPickerScreen.route: (BuildContext context) =>
              DocumentPickerScreen(),
          DocumentViewScreen.route: (BuildContext context) =>
              DocumentViewScreen(),
        },
      ),
    );
  }
}
