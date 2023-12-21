import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_calcu/bloc/calcu/calculadora_bloc.dart';

import 'linea_separadora.dart';
import 'resultado_principal.dart';
import 'resultado_secundario.dart';

class ResultsLabels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculadoraBloc, CalculadoraEstado>(
      builder: (context, state) {

        if(state.primerNum == '0' && state.segundoNum == '0')
        {
          return MainResultText(text: state.resultado.endsWith('.0')
              ? state.resultado.substring(0, state.resultado.length -2)
              : state.resultado
          );
        }


        return Column(
          children: [
            SubResult(text: state.primerNum ),
            SubResult(text: state.operacion ),
            SubResult(text: state.segundoNum.endsWith('.0')
        ? state.segundoNum.substring(0, state.segundoNum.length -2)
            : state.segundoNum ),
            LineSeparator(),
            MainResultText(text: state.resultado.endsWith('.0')
            ? state.resultado.substring(0, state.resultado.length -2)
            : state.resultado),
          ],
        );
      },
    );
  }
}
