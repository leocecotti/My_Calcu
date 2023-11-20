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
    else if (event is OperacionHistorial) {
      yield state.copyWith(
          firstNumber: event.num1,
          mathResult: event.res,
          operation: event.operation,
          secondNumber: event.num2
      );
    }
    //Resultado
    else if (event is ResultadoCalcu) {
        yield* _calculaResultado(event.selectHistorial);
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


  Stream<CalculatorState> _calculaResultado(bool selectHistorial) async*
  {
    final double num1 = double.parse(state.firstNumber);

     double  secondNumber= 0;
    if(selectHistorial)
      secondNumber = double.parse(state.secondNumber);
    else
      secondNumber = double.parse(state.mathResult);

    final double num2 = secondNumber;

    switch(state.operation)
    {
      case '+':
        if(selectHistorial)
          yield state.copyWith(
              secondNumber: state.secondNumber,
              mathResult: '${ num1 + num2 }'
          );
        else
          yield state.copyWith(
            secondNumber: state.mathResult,
            mathResult: '${ num1 + num2 }'
          );

        CalculatorState.selcectHistorial = false;
        print("selectHisto: ${selectHistorial}");
        CalculatorState.operacionTxt = state.firstNumber + ',' + ' + ' + ',' + state.secondNumber + ',' + ' = ' + ',' + state.mathResult;
        CalculatorState.operaciones.add(CalculatorState.operacionTxt);
      break;
      case '-':
        yield state.copyWith(
            secondNumber: state.mathResult,
            mathResult: '${ num1 - num2 }'
        );
        CalculatorState.operacionTxt = state.firstNumber + ',' + ' - ' + ',' + state.secondNumber + ',' + ' = ' + ',' + state.mathResult;
        CalculatorState.operaciones.add(CalculatorState.operacionTxt);
      break;
      case 'x':
        yield state.copyWith(
            secondNumber: state.mathResult,
            mathResult: '${ num1 * num2 }'
        );
        CalculatorState.operacionTxt = state.firstNumber + ',' + ' * ' + ',' + state.secondNumber + ',' + ' = ' + ',' + state.mathResult;
        CalculatorState.operaciones.add(CalculatorState.operacionTxt);
      break;
      case '/':
        yield state.copyWith(
            secondNumber: state.mathResult,
            mathResult: '${ num1 / num2 }'
        );
        CalculatorState.operacionTxt = state.firstNumber + ',' + ' / ' + ',' + state.secondNumber + ',' + ' = ' + ',' + state.mathResult;
        CalculatorState.operaciones.add(CalculatorState.operacionTxt);
      break;
      default:
        yield state;
    }
  }


  }

