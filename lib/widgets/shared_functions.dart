// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nb_utils/nb_utils.dart';

Widget appLoader() {
  return const SpinKitCircle(
  color: Colors.black,
  size: 50.0,
  );
}
Widget pageLoader() {
  return const SpinKitCircle(
  color: Colors.white,
  size: 50.0,
  );
}

toastify(String message){
  return toast(message);
}