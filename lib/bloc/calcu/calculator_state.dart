part of 'calculator_bloc.dart';

class CalculatorState {
  
  final String mathResult;
  final String firstNumber;
  final String secondNumber;
  final String operation;
  static String operacionTxt = '';
  static List <String> operaciones = List.empty(growable: true);
  static bool selcectHistorial = false;

  CalculatorState({
    this.mathResult = '0',
    this.firstNumber = '',
    this.secondNumber = '',
    this.operation = ''
  });

  //crea copias de un estado
  CalculatorState copyWith ({
    String? mathResult,
    String? firstNumber,
    String? secondNumber,
    String? operation,
  })=> CalculatorState(
    mathResult: mathResult ?? this.mathResult,
    firstNumber: firstNumber ?? this.firstNumber,
    secondNumber: secondNumber ?? this.secondNumber,
    operation: operation ?? this.operation,
  );


}

