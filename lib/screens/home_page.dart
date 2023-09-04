import 'dart:math';
import 'package:bmi_calculator/screens/components/table.dart';
import 'package:flutter/material.dart';

String bmiResult = "";
String bmiCatalog = "";
String statusLabel = "¡Ingresa tus párametros!";

void determineBmi(double bmi) {
  bmiResult = bmi.toStringAsFixed(2);

  bmiCatalog = "Delgadez Severa";
  if (bmi >= 16.0) {
    bmiCatalog = "Delgadez Moderada";
  }
  if (bmi >= 17.0) {
    bmiCatalog = "Delgadez ligera";
  }
  if (bmi >= 18.5) {
    bmiCatalog = "Peso Normal";
  }
  if (bmi >= 25.0) {
    bmiCatalog = "Sobrepeso";
  }
  if (bmi >= 30.0) {
    bmiCatalog = "Obesidad tipo I";
  }
  if (bmi >= 35.0) {
    bmiCatalog = "Obesidad tipo II";
  }
  if (bmi >= 40.0) {
    bmiCatalog = "Obesidad tipo III";
  }
  statusLabel = "Tienes $bmiCatalog, tu IMC es $bmiResult";
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  void calculate() {
    String heightValue = heightController.text;
    String weightValue = weightController.text;
    if (heightValue.isEmpty || weightValue.isEmpty) {
      statusLabel = "¡Ingresa tus párametros!";
      setState(() {});
      return;
    }
    double height = double.parse(heightValue);
    double weight = double.parse(weightValue);
    double bmi = weight / double.parse(pow(height, 2).toString());
    determineBmi(bmi);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var heightField = BodyParam(
      fieldText: "Altura",
      placeHolder: "Ingrese su altura (m)",
      textInputController: heightController,
    );

    var weightField = BodyParam(
      fieldText: "Peso",
      placeHolder: "Ingrese su peso (kg)",
      textInputController: weightController,
    );

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("BMI Calculator"),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Theme.of(context).cardColor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: heightField,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: weightField,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Text(
                statusLabel,
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: ElevatedButton(
                  onPressed: calculate, child: const Text("Calcular")),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: const BmiTable())
          ],
        ));
  }
}

class BodyParam extends StatefulWidget {
  final String fieldText;
  final String placeHolder;
  final TextEditingController? textInputController;

  const BodyParam(
      {super.key,
      this.fieldText = "TextInput",
      this.placeHolder = "Ingrese texto aquí",
      this.textInputController});

  @override
  State<BodyParam> createState() => _BodyParamState();
}

class _BodyParamState extends State<BodyParam> {
  @override
  void dispose() {
    if (widget.textInputController != null) {
      widget.textInputController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Text(
            "${widget.fieldText}: ",
            style: const TextStyle(fontSize: 21),
          ),
        ),
        SizedBox(
          width: 150,
          height: 30,
          child: TextField(
            controller: widget.textInputController,
            decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                hintText: widget.placeHolder),
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.number,
          ),
        )
      ],
    );
  }
}
