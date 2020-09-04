import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/document_bloc.dart';
import 'bloc/picker_bloc.dart';
import 'screens/document_picker_screen.dart';
import 'screens/document_view_screen.dart';
import 'screens/welcome_screen.dart';

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
        debugShowCheckedModeBanner: false,
        title: 'DJVU_PDF_Reader',
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
