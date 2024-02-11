import 'package:flutter/material.dart';
import 'package:thesportsapp/constants/colors.dart';

const TextStyle descriptionStyle =
    TextStyle(fontSize: 15, color: textLight, fontWeight: FontWeight.w400);

const textInputdecoration = InputDecoration(
  hintText: "Email",
  hintStyle: TextStyle(color: textDark, fontSize: 15),
  fillColor: mainPrimary,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: textLight, width: 1),
    borderRadius: BorderRadius.all(
      Radius.circular(100),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: textLight, width: 1),
    borderRadius: BorderRadius.all(
      Radius.circular(100),
    ),
  ),
);
