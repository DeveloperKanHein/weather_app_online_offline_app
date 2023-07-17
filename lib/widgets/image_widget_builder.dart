import 'dart:io';
import 'package:flutter/material.dart';

Widget imageWidgetBuilder({required bool isOnline, required String link}) {
  return isOnline
      ? Image.network(
          "http:$link",
          width: 40,
        )
      : Image.file(File(link));
}
