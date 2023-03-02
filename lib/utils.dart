import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Constants.dart';

DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child('TvWebApp');

showToast(BuildContext context, Color color, String data) {
  FToast fToast;

  fToast = FToast();
  fToast.init(context);

  Widget toast = Container(
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: color,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check, color: Colors.white),
        SizedBox(
          width: 10,
        ),
        Text(
          data,
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  );

  // Custom Toast Position
  fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      positionedToastBuilder: (context, child) {
        return Positioned(
          child: child,
          top: 10,
          left: 0,
          right: 0,
        );
      });
}

class FormTextField extends StatelessWidget {
  String text;
  TextEditingController editingController;

  FormTextField(this.text, this.editingController);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: TextField(
        controller: editingController,
        decoration: InputDecoration(
          border: null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.2, strokeAlign: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue.shade900,
              width: 0.2,
            ),
          ),
          hintText: text,
          contentPadding: EdgeInsets.all(12),
        ),
      ),
    );
  }
}

Expanded columnText(String text) {
  return Expanded(
    child: Center(
      child: Text(text, style: textStyleBold(), textAlign: TextAlign.center),
    ),
  );
}
