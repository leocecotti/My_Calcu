import 'package:my_calcu/bloc/calcu/calculadora_bloc.dart';
import 'package:my_calcu/screens/my_calcu_pantalla.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(AppState());


class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CalculadoraBloc>(create: ( _ ) => CalculadoraBloc() )
        ],
        child: MyApp()
    );
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: CalculatorScreen(),
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black
      ),
    );
  }
}