import 'package:flutter/material.dart';
import 'package:frontend/constants/color.dart';

const TextStyle descriptionStyle = TextStyle(
  fontSize: 20,
  color: Color.fromARGB(221, 8, 1, 40),
  //fontWeight: FontWeight.w100, // Light font weight
);

const textInputDecoration = InputDecoration(
  hintText: "email",
  hintStyle: TextStyle(color: textLight, fontSize: 15),
  fillColor: bgBlack,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: mainYellow, width: 1),
    borderRadius: BorderRadius.all(Radius.circular(100)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: mainYellow, width: 1),
    borderRadius: BorderRadius.all(Radius.circular(100)),
  ),
  // set text color to white
  labelStyle: TextStyle(color: Colors.white),
);
