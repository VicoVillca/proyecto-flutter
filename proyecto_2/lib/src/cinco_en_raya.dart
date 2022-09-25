import 'package:flutter/material.dart';
import 'package:material/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:proyecto_2/src/widget_button.dart';
class CincoEnRaya extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> _CincoEnRaya();

}

class _CincoEnRaya extends State<CincoEnRaya>{
  //Lista de variables
  int row=12;
  
  List<List<int>> tablero =  [[]];
  List<List<bool>> vista =  [[false]];
  //funciones Autowireds
  @override
  Widget build(Object context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('BuscaMinas'),centerTitle: true),
      body: Column(
        
      mainAxisAlignment: MainAxisAlignment.center,
      children: getColumnas()/*[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:getFilas(1),
        ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetButton.numButton(
                    textNum: !vista[0][0]?'':tablero[0][0].toString(),
                    myButtonTap: () => click(0, 0),
                  ),
          ],
        )
      ],*/
    ),
    );
  }
 Widget Instrucciones(){
  return Container(
    padding: EdgeInsets.all(5),
    child: Text(
      "el juego consta de $row minas, encuentralas sin tocarlas y coloca una banderita",
      style: TextStyle(color: Colors.white, fontSize: 12),
      ),
  ) ;
 }
  Widget contenedor(int x, int y){
    
    if(contarMinas()==0){
      CrearTablero();
    }
    return GestureDetector(
      onTap: () => {
        //print(tablero[x][y])
        //print(Random().nextInt(10))
      },
      child: Container(
        margin: EdgeInsets.all(1),
        height: 50,
        width: 50,
        color:Colors.white,
        child:
        vista[x][y]?(
        tablero[x][y]<0?
        Container(
          padding: EdgeInsets.all(5),
          child: Image.asset("assets/mina2.png",width: 5,),
        ) : 
        Container(
          alignment: Alignment.center,
          child: Text(
            tablero[x][y]==0?"":tablero[x][y].toString(),
            
            style: TextStyle(
              fontSize: 28,
              color: tablero[x][y]==1?Colors.blue:tablero[x][y]==2?Colors.green:Colors.red,
              
            )
          ),
        )
          
          ):ElevatedButton(
            onPressed: () {
              
              Marcar(x,y);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            child: Text(
              "",
              
            ),
          ),
      ),
    );
  }
  List<Widget> getColumnas(){
    List<Widget> lista =[];
    lista.add(Instrucciones());
      for(int j=1;j<row;j++){
        lista.add( Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:getFilas(j),
        ),);
      }
      
    return lista;
  }
  List<Widget> getFilas(int i){
    List<Widget> lista =[];
      for(int j=1;j<row;j++){
        lista.add(contenedor(i,j));
      }
      
    return lista;
  }


  int contarMinas(){
    int nro =0;
    for (var row in tablero) {
      for(var row2 in row){
        if(row2<0)
        nro++;
      }
    }
    return nro;
  }
  void linpiarTablero(){
    print("Limpiamos tabler");
    setState(() {
       tablero = List.generate(row+1,
        (i) => List.generate(row+1, (j) => 0, growable: false),
        growable: false);

        vista = List.generate(row,
        (i) => List.generate(row, (j) => false, growable: false),
        growable: false);
    });
  }

  void CrearTablero(){
    print("creamos tablero");
    linpiarTablero();
    print("limites");
    print(tablero.length);
    print(tablero[0].length);
    for(int i=0;i<row;i++){
      
      var x = Random().nextInt(row-1)+1;
      var y = Random().nextInt(row-1)+1;
      while(tablero[x][y]<0){
        x = Random().nextInt(row-1)+1;
        y = Random().nextInt(row-1)+1;
      }
      print('$x  v-  $y');
      setState(() {
        tablero[x][y]=-10;

        tablero[x-1][y-1]++;
        tablero[x-1][y]++;
        tablero[x-1][y+1]++;

        tablero[x][y-1]++;
        
        tablero[x][y+1]++;

        tablero[x+1][y-1]++;
        tablero[x+1][y]++;
        tablero[x+1][y+1]++;
      }); 
      
    }
    print(tablero);
    print(contarMinas());
  }
  void Marcar(int x,int y){
    if(x>0 && x<row &&y>0 && y<row &&!vista[x][y]){
      print("Marcamos $x - $y");
      if(tablero[x][y]<0){
        //estamos seleccionado una mina
        mostrarTodoVisible();
        alerta(context,"Perdiste, Vuelve a intentarlo!");
      }else{
        setState(() {
          vista[x][y]=true;
        });

        if(tablero[x][y]==0){
          Marcar(x-1, y-1);
          Marcar(x-1, y);
          Marcar(x-1, y+1);

          Marcar(x, y-1);
          Marcar(x, y);
          Marcar(x, y+1);
          
          Marcar(x+1, y-1);
          Marcar(x+1, y);
          Marcar(x+1, y+1);

        }
        VerificarSiGano();
      }
    }
  }
  void mostrarTodoVisible(){
    setState(() {
      vista = List.generate(row,
        (i) => List.generate(row, (j) => true, growable: false),
        growable: false);
    });
  }

  void VerificarSiGano(){
    int sinMarcar=0;
    for(int i=1;i<row;i++){
      for(int j=1;j<row;j++){
        if(vista[i][j]==false){
          sinMarcar++;
        }
      }
    }
    /*for(int i=1;i<row;i++){
      for(int j=1;j<row;j++){
        if(vista[i][j]==false && tablero[i][j]<0){
          nro++;
        }
      }
    }*/
    print("nro sin marcar $sinMarcar");
    
    if(sinMarcar==row){
      //gano
      alerta(context, "Ganaste!!!");
    }
  }


  Future alerta(BuildContext context,String x){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(x),
        content: const Text('Reiniciar?'),
        actions: [
          TextButton(onPressed: () {
            SystemNavigator.pop();
          }, child: Text('NO')),
          TextButton(onPressed: () {
            CrearTablero();
            Navigator.pop(context);
          }, child: Text('SI')),
        ],
      );
    });
  }
}

