part of 'calculadora_bloc.dart';

class CalculadoraEstado {
  
  final String resultado;
  final String primerNum;
  final String segundoNum;
  final String operacion;
  static String operacionTxt = '';
  static List <String> operaciones = List.empty(growable: true);
  static bool selcectHistorial = false;

  CalculadoraEstado({
    this.resultado = '0',
    this.primerNum = '',
    this.segundoNum = '',
    this.operacion = ''
  });

  //crea copias de un estado
  CalculadoraEstado copyWith ({
    String? mathResult,
    String? firstNumber,
    String? secondNumber,
    String? operation,
  })=> CalculadoraEstado(
    resultado: mathResult ?? this.resultado,
    primerNum: firstNumber ?? this.primerNum,
    segundoNum: secondNumber ?? this.segundoNum,
    operacion: operation ?? this.operacion,
  );


}

