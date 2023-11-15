import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {

  CalculatorBloc() : super(CalculatorState());
  // Stream<String> retornaString() async* {
  //   yield 'Hola Mundo';
  // }



  @override
  Stream<CalculatorState> mapEventToState(
    CalculatorEvent event,
  ) async* {
    //Reiniciar calcu
    if (event is ResetAC) {
      yield* this._resetAC();
      //Agregar numeros
    } else if (event is AddNumber) {
      yield state.copyWith(
        mathResult: (state.mathResult == '0'
        ? event.number
        : state.mathResult + event.number)
      );
    }
    //Camiar signo - a + y viceversa
    else if (event is CambiarNegativoPositivo) {
      yield state.copyWith(
        mathResult: state.mathResult.contains('-')
            ? state.mathResult.replaceFirst('-','')
            : '-' + state.mathResult
      );
    }
    //Borrar ultimo digito
    else if (event is BorrarUltimoNumero) {
      yield state.copyWith(
        mathResult: state.mathResult.length > 1
            ? state.mathResult.substring(0, state.mathResult.length -1)
            : '0'
      );
    }
    //Operacion Division
    else if (event is OperacionCalc) {
      yield state.copyWith(
          firstNumber: state.mathResult,
          mathResult: '0',
          operation: event.operation,
          secondNumber: '0'
      );
    }
    //Operacion Division
    else if (event is ResultadoCalcu) {
      yield* _calculaResultado();
    }
  }

    Stream<CalculatorState> _resetAC() async*
    {
      yield CalculatorState(
          firstNumber: '',
          mathResult: '0',
          secondNumber: '',
          operation: ''
      );
    }

  Stream<CalculatorState> _calculaResultado() async*
  {
    final double num1 = double.parse(state.firstNumber);
    final double num2 = double.parse(state.mathResult);

    switch(state.operation)
    {
      case '+':
        yield state.copyWith(
          secondNumber: state.mathResult,
          mathResult: '${ num1 + num2 }'
        );
      break;
      case '-':
        yield state.copyWith(
            secondNumber: state.mathResult,
            mathResult: '${ num1 - num2 }'
        );
      break;
      case 'x':
        yield state.copyWith(
            secondNumber: state.mathResult,
            mathResult: '${ num1 * num2 }'
        );
      break;
      case '/':
        yield state.copyWith(
            secondNumber: state.mathResult,
            mathResult: '${ num1 / num2 }'
        );
      break;
      default:
        yield state;
    }
  }


  }

