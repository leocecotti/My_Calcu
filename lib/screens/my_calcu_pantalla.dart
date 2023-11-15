import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_calcu/bloc/calcu/calculator_bloc.dart';

import 'package:my_calcu/widgets/resultado_labels.dart';
import 'package:my_calcu/widgets/calcu_boton.dart';





class CalculatorScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    final calculatorBloc = BlocProvider.of<CalculatorBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric( horizontal: 10 ),
          color: Colors.red,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.history),
                    iconSize: 40,
                    onPressed: ()
                    {
                      List<String> colorList = ['aaa','bbb','ccc'];
                      showAlertDialog(context, colorList, Colors.red);
                    } ,
                  ),
                ],
              ),

              Expanded(
                child: Container(),
              ),

              ResultsLabels(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton( 
                    text: 'AC',
                    bgColor: Color(0xffA5A5A5 ),
                    onPressed: () => calculatorBloc.add( ResetAC() )  ,
                  ),
                  CalculatorButton( 
                    text: '+/-',
                    bgColor: Color(0xffA5A5A5 ),
                    onPressed: () => calculatorBloc.add(CambiarNegativoPositivo()),
                  ),
                  CalculatorButton( 
                    text: 'del',
                    bgColor: Color(0xffA5A5A5 ),
                    onPressed: () => calculatorBloc.add(BorrarUltimoNumero()),
                  ),
                  CalculatorButton( 
                    text: '/',
                    bgColor: Color(0xffF0A23B ),
                    onPressed: () => calculatorBloc.add(OperacionCalc('/')),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton( 
                    text: '7',
                    onPressed: () => calculatorBloc.add( AddNumber('7') ),
                  ),
                  CalculatorButton( 
                    text: '8',
                    onPressed: () => calculatorBloc.add( AddNumber('8') ),
                  ),
                  CalculatorButton( 
                    text: '9',
                    onPressed: () => calculatorBloc.add( AddNumber('9') ),
                  ),
                  CalculatorButton( 
                    text: 'X',
                    bgColor: Color(0xffF0A23B ),
                    onPressed: () => calculatorBloc.add(OperacionCalc('x')),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton( 
                    text: '4', 
                    onPressed: () => calculatorBloc.add( AddNumber('4')),
                  ),
                  CalculatorButton( 
                    text: '5', 
                    onPressed: () => calculatorBloc.add( AddNumber('5')),
                  ),
                  CalculatorButton( 
                    text: '6', 
                    onPressed: () => calculatorBloc.add( AddNumber('6')),
                  ),
                  CalculatorButton( 
                    text: '-',
                    bgColor: Color(0xffF0A23B ),
                    onPressed: () => calculatorBloc.add(OperacionCalc('-')),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton( 
                    text: '1', 
                    onPressed: () => calculatorBloc.add( AddNumber('1')),
                  ),
                  CalculatorButton( 
                    text: '2', 
                    onPressed: () => calculatorBloc.add( AddNumber('2')),
                  ),
                  CalculatorButton( 
                    text: '3', 
                    onPressed: () => calculatorBloc.add( AddNumber('3')),
                  ),
                  CalculatorButton(
                    text: '+',  
                    bgColor: Color(0xffF0A23B ),
                    onPressed: () => calculatorBloc.add(OperacionCalc('+')),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton( 
                    text: '0', 
                    big: true,
                    onPressed: () => calculatorBloc.add( AddNumber('0')),
                  ),
                  CalculatorButton( 
                    text: '.', 
                    onPressed: () => calculatorBloc.add( AddNumber('.')),
                  ),
                  CalculatorButton( 
                    text: '=',
                    bgColor: Color(0xffF0A23B ),
                    onPressed: () {
                      calculatorBloc.add(ResultadoCalcu());
                      },
                  ),
                ],
              ),
            ],
          ),
        ),
      )
   );
  }

  showAlertDialog(BuildContext context, List<String> imagenes, Color color) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Historial Operaciones", textAlign: TextAlign.left),
      content: SizedBox(
          width: double.maxFinite,
          child:Container(
            child:  Container(
                width: double.infinity,
                height: double.infinity,
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                ListView.builder(
                shrinkWrap: true,
                  itemCount: imagenes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Container(
                          child: Padding(padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                            child: Text(imagenes[index]),)
                      ),
                      onTap: () {
                        Navigator.pop(context);


                      },
                    );
                  },
                ),
  ]),
          ),
      ),
    ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}