import 'dart:js_util';
import 'package:flutter/material.dart';
import 'package:flutter_application_calculator/colors.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var input="";
  var hinput=false;
  var output="";
  var operator="";
  var outputSize1=35.0;
  onButtonClick(value)
  {
    if (value == "C"){
      hinput=false;
      input="";
      output="";
    }
    else if (value == "<"){
      if (input.isNotEmpty){
      input = input.substring(0,input.length-1);}

    } else if (value == "="){
      if (input.isNotEmpty){
      var inputnew = input;
      inputnew = input.replaceAll("×","*");
      Parser p1 = Parser();
      Expression expression = p1.parse(inputnew);
      ContextModel cm =ContextModel();
      var fValue = expression.evaluate(EvaluationType.REAL,cm);
      output = fValue.toString();
      if(output.endsWith(".0")){
      output=output.substring(0,output.length-2);}}
    input=output;
    hinput=true;
    outputSize1=52.0;
    }

    else{
      input=input+value;
    }

    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    var outputSize12 = outputSize1;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [ 
                    Text(hinput ? "":input, 
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white
                      )
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(output, 
                    style: TextStyle(
                      fontSize: outputSize1,
                      color: Colors.white.withOpacity(0.7),
                      )
                    ),
                    SizedBox(height: 30)
                    ],
                  )
                ),
              ),
            Row(children: [
              button(text:"C",tbground: opColor),
              button(text:"%",tbground: opColor),
              button(text:"<",tbground: opColor),
              button(text:"/",tbground: opColor),
              ],
            ),
            Row(children: [
              button(text:"7"),
              button(text:"8"),
              button(text:"9"),
              button(text:"×",tbground: opColor),
              ],
            ),
            Row(children: [
              button(text:"4"),
              button(text:"5"),
              button(text:"6"),
              button(text:"-",tbground: opColor),
              ],
            ),
            Row(children: [
              button(text:"1"),
              button(text:"2"),
              button(text:"3"),
              button(text:"+",tbground: opColor),
              ],
            ),
            Row(children: [
              button(text:"00"),
              button(text:"0"),
              button(text:"."),
              button(text:"=",tbground: Colors.purple),
              ],
            )
          ],
        ),
      );
  }
  Widget button({text,tcolor=Colors.white,tbground=Color2}){
    return Expanded(child: Container(
                margin: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(
                      //borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(40),
                    primary: tbground),
                onPressed: ()=>onButtonClick(text),
                child: Text(text, style: TextStyle(
                  fontSize: 22,
                  color: tcolor,
                  fontWeight: FontWeight.bold,
                ))),
                ),
             );
  }
}
