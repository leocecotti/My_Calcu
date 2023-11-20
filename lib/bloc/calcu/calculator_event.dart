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

class OperacionHistorial extends CalculatorEvent{
  final String num1;
  final String num2;
  final String operation;
  final String res;

  OperacionHistorial(this.num1, this.num2, this.operation, this.res);
}

class ResultadoCalcu extends CalculatorEvent{
  bool selectHistorial = false;

  ResultadoCalcu(this.selectHistorial);
}
