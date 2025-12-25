import 'package:flutter/material.dart';
import 'package:frontend/constants/color.dart';

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

//const appbar
