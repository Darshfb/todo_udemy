import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget CustomTextFormField({
  required TextEditingController? controller,
  ValueChanged<String>? submit,
  required TextInputType? keyboardType,
  required FormFieldValidator<String>? validator,
  required String label,
  required String hintText,
  required IconData prefixIcon,
  GestureTapCallback? onTap,
  int? lines,
}) =>
// so now we here have much of Strings...
// let's try to change all of them from here
    TextFormField(
      maxLines: lines,
      onTap: onTap,
      controller: controller,
      keyboardType: keyboardType,
      onFieldSubmitted: submit,
      validator: validator,
      decoration: InputDecoration(
        labelText: label.tr(),
        prefixIcon: Icon(prefixIcon),
        hintText: hintText.tr(),
        isDense: true,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
