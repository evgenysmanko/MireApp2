import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  var _textController = TextEditingController();
  bool _digit = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _textController.addListener(() {
      if (_textController.text.length == 4) {
        setState(() {
          _digit = true;
          print("object");
        });
      }
    });
    super.initState();
  }

  var maskFormatter = new MaskTextInputFormatter(mask: '%%%%-##-##', filter: {"#": RegExp(r'[0-9]'), "%": RegExp(r'[А-Я]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Привет!",
            style: TextStyle(fontSize: 35),
          ),
          Container(
              width: 200,
              child: Column(
                children: [
                  Text(
                    "Введи название группы:",
                    style: TextStyle(fontSize: 15),
                  ),
                  TextField(
                    controller: _textController,
                    keyboardType: _digit ? TextInputType.number : TextInputType.text,
                    inputFormatters: [maskFormatter],
                    decoration: InputDecoration(hintText: "Например, ББСО-01-17"),
                  ),
                ],
              )),
          FloatingActionButton(
            child: Icon(Icons.arrow_forward),
          )
        ],
      ),
    ));
  }

  _groupSelectedClick(String groupName) {}
}
