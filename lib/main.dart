import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

void main() {runApp(const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Лабораторная работа 2",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();
  final _field = TextEditingController();
  final _check = GlobalKey();
  bool agreement = false;
  FirstPage({super.key});


  @override
  Widget build(BuildContext context) {
    String helpText = 'Введите число фибоначи!!!';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Лабовский Максим Алексеевич'),
      ),
      body: 
      Padding(padding: const EdgeInsets.all(20),
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20,),
              TextFormField(
                controller: _field,
                validator: (value) {
                  if (value!.isEmpty) return 'Пожалуйста введите текст!!!';
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [//FilteringTextInputFormatter.digitsOnly, 
                FilteringTextInputFormatter.allow(RegExp(r'[0-9,\b]'))],
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.star), border: const OutlineInputBorder(),
                  hintText: "Например: 6",
                  labelText: 'Номер числа фибоначи',
                  helperText: helpText,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.green,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.purple,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              CheckBoxWidget(key:  _check,agreement: agreement),
              ElevatedButton(onPressed: () {
               CheckBoxWidget? a = _check.currentWidget as CheckBoxWidget?;
               agreement = a!.agreement;
                if(!agreement) {
                  showDialog(
                    context: context, 
                    builder: (BuildContext context) => 
                    AlertWidget(text: "Вы не подтвердили согласие на обработку данных!"));
                    
                }
                else if (_formKey.currentState!.validate() && int.parse(_field.text) > 0){
                  Navigator.push(context,
                  MaterialPageRoute(builder: (content) {
                    return SecondPage(numberFibonachi: int.parse(_field.text));
                  }));
                }
                else {
                  showDialog(
                    context: context, 
                    builder: (BuildContext context) => 
                    AlertWidget(text: "Число Фибоначи не введено или равно 0!"));
                    // {
                    //   return AlertDialog(
                    //     title: const Text('Номер числа фибоначи не введен или равен 0!'),
                    //     content: const Text(''),
                    //     actions: [
                    //       OutlinedButton(onPressed: Navigator.of(context).pop, child: const Text('Ok'))
                    //     ],
                    //   );
                    // });
                }
                
              },
              child: const Text('Расчитать число Фибоначи')
              ),
            
            ],
          )
        )
      ),
      ),
      
    );
  }
}

class CheckBoxWidget extends StatefulWidget{
  bool agreement;
  CheckBoxWidget({super.key, required this.agreement});
  
  @override
  _CheckBoxWidget createState() => _CheckBoxWidget(agreement);
}

class _CheckBoxWidget extends State<CheckBoxWidget>{
  bool agreement;

  _CheckBoxWidget(this.agreement);
  @override
  Widget build(BuildContext context) {
    
    return CheckboxListTile(
              value: widget.agreement, 
              title: const Text('Я согласен на обработку данных(сюда не прикрепляю, так как ее никто никогда не читал)'),
              onChanged: (bool? value) { 
                if(value != null){
                  setState(() => widget.agreement = value);
                }},
              );
  }
}

class AlertWidget extends StatefulWidget{
  String text;
  AlertWidget({super.key, required this.text});

  @override
  _AlertWidgetState createState() => _AlertWidgetState(this.text);
}

class _AlertWidgetState extends State<AlertWidget> {
  String text;

  _AlertWidgetState(this.text);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(text),
      content: const Text(''),
      actions: [
        OutlinedButton(onPressed: Navigator.of(context).pop, child: const Text('Ok'))
      ],
      );
  }
}

class SecondPage extends StatelessWidget{
  int numberFibonachi;
  SecondPage({super.key, required this.numberFibonachi});
  


  @override
  Widget build(BuildContext context) {
    int printNumber = fibonachiCalc(numberFibonachi);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Лабовский Максим Алексеевич'),
      ),
      body: Center(
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              
              Text('Ваше число Фибоначи: $printNumber'),            
            ],
          )
        )
      ),
      
    );
  }
}

int fibonachiCalc (int n){
  if(n == 1 || n == 2) return 1;
  return fibonachiCalc(n -1) + fibonachiCalc(n-2);
}