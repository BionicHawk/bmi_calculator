import "package:flutter/material.dart";

showAlertDialog(BuildContext context,
    {String bmiCatalog = "", String bmiResult = ""}) {
  Widget okButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text("¡Ok!"));

  AlertDialog alert = AlertDialog(
    title: Text(bmiCatalog),
    content: Text(bmiResult),
    actions: [okButton],
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
