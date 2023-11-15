part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorEvent {}

class ResetAC extends CalculatorEvent{}

class AddNumber extends CalculatorEvent{
  final String number;
  AddNumber(this.number);
}

class CambiarNegativoPositivo extends CalculatorEvent{}

class BorrarUltimoNumero extends CalculatorEvent{}

class OperacionCalc extends CalculatorEvent{
  final String operation;

  OperacionCalc(this.operation);
}

class ResultadoCalcu extends CalculatorEvent{}
