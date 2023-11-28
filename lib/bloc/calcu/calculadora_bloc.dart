import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calculator_event.dart';
part 'calculadora_state.dart';

class CalculadoraBloc extends Bloc<CalculadoraEventos, CalculadoraEstado> {

  CalculadoraBloc() : super(CalculadoraEstado());
  // Stream<String> retornaString() async* {
  //   yield 'Hola Mundo';
  // }



  @override
  Stream<CalculadoraEstado> mapEventToState(
    CalculadoraEventos event,
  ) async* {
    //Reiniciar calcu
    if (event is ResetAC) {
      yield* this._resetAC();
      //Agregar numeros
    } else if (event is AddNumber) {
      yield state.copyWith(
        mathResult: (state.resultado == '0'
        ? event.number
        : state.resultado + event.number)
      );
    }
    //Camiar signo - a + y viceversa
    else if (event is CambiarNegativoPositivo) {
      yield state.copyWith(
        mathResult: state.resultado.contains('-')
            ? state.resultado.replaceFirst('-','')
            : '-' + state.resultado
      );
    }
    //Borrar ultimo digito
    else if (event is BorrarUltimoNumero) {
      yield state.copyWith(
        mathResult: state.resultado.length > 1
            ? state.resultado.substring(0, state.resultado.length -1)
            : '0'
      );
    }
    //Operaciones Aritmeticas
    else if (event is OperacionCalc) {
        yield state.copyWith(
            firstNumber: state.resultado,
            mathResult: '0',
            operation: event.operation,
            secondNumber: '0'
        );
    }
    //Operaciones Historial
    else if (event is OperacionHistorial) {
      yield state.copyWith(
          firstNumber: event.num1,
          mathResult: event.res,
          operation: event.operacion,
          secondNumber: event.num2
      );
    }
    //Resultados
    else if (event is ResultadoCalcu) {
        yield* _calculaResultado(event.selectHistorial);
    }
  }

    Stream<CalculadoraEstado> _resetAC() async*
    {
      yield CalculadoraEstado(
          primerNum: '',
          resultado: '0',
          segundoNum: '',
          operacion: ''
      );

    }


  Stream<CalculadoraEstado> _calculaResultado(bool selectHistorial) async*
  {
    final double num1 = double.parse(state.primerNum);

     double  segundoNum= 0;
    if(selectHistorial)
      segundoNum = double.parse(state.segundoNum);
    else
      segundoNum = double.parse(state.resultado);

    final double num2 = segundoNum;

    switch(state.operacion)
    {
      case '+':
        if(selectHistorial)
          yield state.copyWith(
              secondNumber: state.segundoNum,
              mathResult: '${ num1 + num2 }'
          );
        else
          yield state.copyWith(
            secondNumber: state.resultado,
            mathResult: '${ num1 + num2 }'
          );

        CalculadoraEstado.selcectHistorial = false;
        print("selectHisto: ${selectHistorial}");
        CalculadoraEstado.operacionTxt = state.primerNum + ',' + ' + ' + ',' + state.segundoNum + ',' + ' = ' + ',' + state.resultado;
        CalculadoraEstado.operaciones.add(CalculadoraEstado.operacionTxt);
      break;
      case '-':
        yield state.copyWith(
            secondNumber: state.resultado,
            mathResult: '${ num1 - num2 }'
        );
        CalculadoraEstado.operacionTxt = state.primerNum + ',' + ' - ' + ',' + state.segundoNum + ',' + ' = ' + ',' + state.resultado;
        CalculadoraEstado.operaciones.add(CalculadoraEstado.operacionTxt);
      break;
      case 'x':
        yield state.copyWith(
            secondNumber: state.resultado,
            mathResult: '${ num1 * num2 }'
        );
        CalculadoraEstado.operacionTxt = state.primerNum + ',' + ' * ' + ',' + state.segundoNum + ',' + ' = ' + ',' + state.resultado;
        CalculadoraEstado.operaciones.add(CalculadoraEstado.operacionTxt);
      break;
      case '/':
        yield state.copyWith(
            secondNumber: state.resultado,
            mathResult: '${ num1 / num2 }'
        );
        CalculadoraEstado.operacionTxt = state.primerNum + ',' + ' / ' + ',' + state.segundoNum + ',' + ' = ' + ',' + state.resultado;
        CalculadoraEstado.operaciones.add(CalculadoraEstado.operacionTxt);
      break;
      default:
        yield state;
    }
  }


  }

