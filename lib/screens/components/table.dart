import "package:flutter/material.dart";

class BmiTable extends StatelessWidget {
  const BmiTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(),
      children: const [
        TableRow(children: [
          ListedElement(value: "Menor a 16"),
          ListedElement(value: "Delgadez Severa")
        ]),
        TableRow(children: [
          ListedElement(value: "Mayor a 16 o igual y Menor a 17"),
          ListedElement(value: "Delgadez Moderada")
        ]),
        TableRow(children: [
          ListedElement(value: "Mayor o igual a 17 y menor a 18.5"),
          ListedElement(value: "Delgadez Ligera")
        ]),
        TableRow(children: [
          ListedElement(value: "Mayor o igual a 18.5 y menor a 25"),
          ListedElement(value: "Peso Normal")
        ]),
        TableRow(children: [
          ListedElement(value: "Mayor o igual a 25 y menor a 30"),
          ListedElement(value: "Sobrepeso")
        ]),
        TableRow(children: [
          ListedElement(value: "Mayor o igual a 30 y menor a 35"),
          ListedElement(value: "Obesidad tipo I")
        ]),
        TableRow(children: [
          ListedElement(value: "Mayor o igual a 35 y menor a 40"),
          ListedElement(value: "Obesidad tipo II"),
        ]),
        TableRow(children: [
          ListedElement(value: "Mayor o igual a 40"),
          ListedElement(value: "Obesidad tipo III")
        ])
      ],
    );
  }
}

class ListedElement extends StatelessWidget {
  final String value;
  const ListedElement({super.key, this.value = "None"});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1),
      child: Text(value, style: const TextStyle(fontSize: 12)),
    );
  }
}
