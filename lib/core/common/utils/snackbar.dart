import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void snackBarMessage(BuildContext context,String message){

  ScaffoldMessenger.of(context)
  ..hideCurrentSnackBar()
  ..showSnackBar(
    SnackBar(content: Text(message))
  );

}