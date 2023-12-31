// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {
  DefaultFormField(
      {Key? key,
       this.controller,
      this.hintText,
       this.labelText,
      // this.prefix,
       required this.validator,
      this.keyboardType,
      this.onTap,
      this.contentPadding,
      this.maxlines})
      : super(key: key);
   TextEditingController? controller;
   String? labelText;
   String? hintText;
   //IconData? prefix;
  final FormFieldValidator<String> validator;
  final TextInputType? keyboardType;
  void Function()? onTap;
  int? maxlines;
  EdgeInsetsGeometry? contentPadding;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      keyboardType: keyboardType,
      controller: controller,
      maxLines: maxlines ,
      validator: validator,
      decoration: InputDecoration(
          contentPadding: contentPadding,
          labelText: labelText,
          hintText: hintText,
     //     prefixIcon: Icon(prefix),
          border: const OutlineInputBorder(
            
              borderRadius: BorderRadius.all(Radius.circular(12)))),
    );
  }
}
