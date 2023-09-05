import 'dart:math';
import 'package:bmi_calculator/screens/components/alert_bmi.dart';
import 'package:bmi_calculator/screens/components/table.dart';
import 'package:flutter/material.dart';

String bmiResult = "";
String bmiCatalog = "";
String recommendation = "sigue así 👍";
String statusLabel = "¡Ingresa tus párametros!";
bool everyFieldIsFilled = false;

void determineBmi(double bmi) {
  bmiResult = bmi.toStringAsFixed(2);
  recommendation =
      "te recomendamos que visites a un espacialista en nutrición para tener una salud mejor 👩‍⚕️";
  bmiCatalog = "Delgadez Severa";
  if (bmi >= 16.0) {
    bmiCatalog = "Delgadez Moderada";
  }
  if (bmi >= 17.0) {
    bmiCatalog = "Delgadez ligera";
  }
  if (bmi >= 18.5) {
    bmiCatalog = "Peso Normal";
    recommendation = "sigue así 👍";
  }
  if (bmi >= 25.0) {
    bmiCatalog = "Sobrepeso";
    recommendation =
        "te recomendamos que visites a un espacialista en nutrición para tener una salud mejor 👩‍⚕️";
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
      everyFieldIsFilled = false;
      setState(() {});
      return;
    }
    everyFieldIsFilled = true;
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

    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkModeEnabled = brightness == Brightness.dark;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("BMI Calculator"),
          backgroundColor: (isDarkModeEnabled)
              ? Theme.of(context).primaryColorDark
              : Theme.of(context).primaryColor,
          foregroundColor: (isDarkModeEnabled)
              ? Theme.of(context).primaryColorLight
              : Theme.of(context).cardColor,
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
                    color: (isDarkModeEnabled)
                        ? Theme.of(context).indicatorColor
                        : Theme.of(context).primaryColorDark,
                    fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: ElevatedButton(
                  onPressed: () {
                    calculate();
                    if (everyFieldIsFilled) {
                      showAlertDialog(context,
                          bmiCatalog: "¡Tienes $bmiCatalog!",
                          bmiResult:
                              "¡Tu índice es $bmiResult, $recommendation!");
                    } else {
                      showAlertDialog(context,
                          bmiCatalog: "Tienes que llenar los campos",
                          bmiResult:
                              "No se pudo determinar tu IMC porque los campos están vacíos");
                    }
                  },
                  child: const Text("Calcular")),
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
