part of 'calculadora_bloc.dart';

@immutable
abstract class CalculadoraEventos {}

class ResetAC extends CalculadoraEventos{}

class AddNumber extends CalculadoraEventos{
  String number;
  AddNumber(this.number);
}

class CambiarNegativoPositivo extends CalculadoraEventos{}

class BorrarUltimoNumero extends CalculadoraEventos{}

class OperacionCalc extends CalculadoraEventos{
  final String operation;

  OperacionCalc(this.operation);
}

class OperacionHistorial extends CalculadoraEventos{
  final String num1;
  final String num2;
  final String operacion;
  final String res;

  OperacionHistorial(this.num1, this.num2, this.operacion, this.res);
}

class ResultadoCalcu extends CalculadoraEventos{
  bool selectHistorial = false;

  ResultadoCalcu(this.selectHistorial);
}
