import 'package:flutter/material.dart';
import 'package:isn_manager/constant/colors.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function(String?) onChange;

  CustomTextField(this.icon, {required this.hint, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        obscureText: hint == 'Password',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$hint is empty';
          }
          return null;
        },
        onSaved: onChange,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}