import 'package:flutter/material.dart';

Widget Function(BuildContext context, int index, Animation<double> animation)
    animationItemBuilder(Widget Function(int index) child,
            {EdgeInsets padding = EdgeInsets.zero}) =>
        (BuildContext context, int index, Animation<double> animation) =>
            FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(animation),
              child: SlideTransition(
                position: Tween<Offset>(
                        begin: const Offset(0, -0.1), end: Offset.zero)
                    .animate(animation),
                child: Padding(
                  padding: padding,
                  child: child(index),
                ),
              ),
            );

TextFormField textFormField(String text, IconData icon, TextInputType inputType,
    AsyncSnapshot<Object?> snapshot, Function(String value) onChangedData) {
  return TextFormField(
    onChanged: (value) => onChangedData(value),
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white70,
        ),
        filled: true,
        labelText: text,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
        errorText: snapshot.hasError ? snapshot.error.toString() : null),
    keyboardType: inputType,
    obscureText: inputType == TextInputType.visiblePassword,
  );
}

TextFormField secondaryTextFormField(String text, String? initialValue, TextInputType inputType,
    AsyncSnapshot<Object?> snapshot, Function(String value) onChangedData) {
  return TextFormField(
    initialValue: initialValue,
    onChanged: (value) => onChangedData(value),
    textAlignVertical: TextAlignVertical.center,
    style: const TextStyle(fontSize: 18),
    decoration: InputDecoration(
        filled: true,
        hintText: text,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10), // Đặt giá trị padding cho chiều cao
        // floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white,
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        errorText: snapshot.hasError && snapshot.error.toString().trim().isNotEmpty
            ? snapshot.error.toString()
            : null),
    keyboardType: inputType,
    obscureText: inputType == TextInputType.visiblePassword,
  );
}

TextFormField primaryTextFormField(
    String text,
    IconData icon,
    TextInputType inputType,
    AsyncSnapshot<Object?> snapshot,
    Function(String value) onChangedData) {
  return TextFormField(
    onChanged: (value) => onChangedData(value),
    decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
        ),
        filled: true,
        labelText: text,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
                width: 2, style: BorderStyle.solid, color: Colors.blueGrey)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
                width: 2, style: BorderStyle.solid, color: Colors.redAccent)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
                width: 2, style: BorderStyle.solid, color: Colors.redAccent)),
        errorText: snapshot.hasError && snapshot.error.toString().isNotEmpty
            ? snapshot.error.toString()
            : null),
    keyboardType: inputType,
    obscureText: inputType == TextInputType.visiblePassword,
  );
}
