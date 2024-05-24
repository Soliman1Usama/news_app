import 'package:flutter/material.dart';
import 'package:news_watcher/core/utils/styles.dart';

class CustomTextFiled extends StatefulWidget {
   const CustomTextFiled({super.key, required this.hintText,  this.prefixIcon,required this.passwordHide, this.controller, this.onSaved, this.validator, this.onFieldSubmitted, this.inputType, this.fieldKey});
  final TextEditingController? controller;
   final Key? fieldKey;

  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;

  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  final String hintText;
  final Icon? prefixIcon;

  final bool passwordHide;

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onFieldSubmitted,
      validator: widget.validator,
      onSaved: widget.onSaved,
      key: widget.fieldKey,
      keyboardType: widget.inputType,
      controller: widget.controller,
      obscureText: widget.passwordHide == true ? _obscureText :false,

      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child:
          widget.passwordHide==true? Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: _obscureText == false ? Colors.blue : Colors.grey,) : Text(""),
        ),
        prefixIcon:widget.prefixIcon,
          labelText: widget.hintText,
          labelStyle: AppStyles.textStyleSemiBold15.copyWith(fontWeight: FontWeight.w400),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),

      ),
    );
  }
}
