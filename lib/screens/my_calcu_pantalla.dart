import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_calcu/bloc/calcu/calculadora_bloc.dart';

import 'package:my_calcu/widgets/resultado_labels.dart';
import 'package:my_calcu/widgets/calcu_boton.dart';

import 'package:assets_audio_player/assets_audio_player.dart';

class CalculatorScreen extends StatelessWidget {

  final Audio audio = Audio('assets/audios/messi.mp3');
  AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  bool reproduce = false;

  @override
  Widget build(BuildContext context) {

    final calculatorBloc = BlocProvider.of<CalculadoraBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric( horizontal: 10 ),
          color: Colors.blueGrey,
          child: Column(
            children: [
          Container(
          color: Colors.black54,
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.history),
                iconSize: 40,
                onPressed: ()
                {
                  if(CalculadoraEstado.operaciones.length > 0)
                    showAlertDialog(context, CalculadoraEstado.operaciones, Colors.red, calculatorBloc);
                  else
                    showDialog(context: context, builder: (ctx) => AlertDialog(
                      title:  Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.history, size: 35,),
                          ),
                          Text("Operaciones", textAlign: TextAlign.left, style: TextStyle(fontSize: 20),)
                        ],
                      ),
                      content: const Text("No hay operaciones realizadas."),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Container(
                            color: Colors.orange,
                            padding: const EdgeInsets.all(14),
                            child: const Text("Aceptar", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                    );
                } ,
              ),
              Text("The Calcu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
              IconButton(
                icon: Image.asset("assets/pro.png"),
                iconSize: 40,
                onPressed: ()
                {
                  if(reproduce == false) {
                    reproduce = true;
                    _assetsAudioPlayer = AssetsAudioPlayer();
                    _assetsAudioPlayer.open(audio);
                    _assetsAudioPlayer.play();
                  }
                  else
                      reproduce = false;

                } ,
              ),
            ],
          ),
          ),


              Expanded(
                child: Container(),
              ),

              ResultsLabels(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton( 
                    text: 'CE',
                    bgColor: Color(0xffA5A5A5 ),
                    onPressed: () => calculatorBloc.add( ResetAC() )  ,
                  ),
                  CalculatorButton( 
                    text: '+/-',
                    bgColor: Color(0xffA5A5A5 ),
                    onPressed: () => calculatorBloc.add(CambiarNegativoPositivo()),
                  ),
                  CalculatorButton( 
                    text: '<-',
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
                      calculatorBloc.add(ResultadoCalcu(CalculadoraEstado.selcectHistorial));
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

  showAlertDialog(BuildContext context, List<String> imagenes, Color color, CalculadoraBloc calculatorBloc) {

    Widget salirButton = ElevatedButton(
        onPressed: (){

          Navigator.pop(context);

        },

        style: ElevatedButton.styleFrom(
          primary: Colors.orange,
          alignment: Alignment.center,
            fixedSize: Size.infinite,
          minimumSize: Size.fromHeight(40)
        ),
        child:Text("Salir", style: TextStyle(fontSize: 16))
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.blueGrey,
      title: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.history, size: 35,),
          ),
          Text("Operaciones", textAlign: TextAlign.left, style: TextStyle(fontSize: 22),)
        ],
      ),
      content: SizedBox(
          width: double.maxFinite,
          child:Container(
            color: Colors.blueGrey,
            child:  Container(
                width: double.infinity,
                height: double.infinity,
              color: Colors.blueGrey,
                child:
                Column(
                    mainAxisSize:MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: imagenes.length,
                          itemBuilder: (BuildContext context, int index) {
                            List<String> item = imagenes[index].split(',');
                            return ListTile(
                              title: Container(
                                  child: Padding(padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                                    child:
                                    Text(
                                      item[0] + item[1] + item[2] + item[3] + item[4],
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  )
                              ),
                              onTap: () {

                                CalculadoraEstado.selcectHistorial = true;

                                List<String> strarray = imagenes[index].split(',');

                                calculatorBloc.add( ResetAC() );

                                calculatorBloc.add( OperacionHistorial(
                                    strarray[0],
                                    strarray[2],
                                    strarray[1].toString().trim(),
                                    strarray[4]) );

                                calculatorBloc.add( ResultadoCalcu(CalculadoraEstado.selcectHistorial) );

                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                    ),

  ]),
          ),
      ),
    ),
      actions: [
        salirButton
      ],
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