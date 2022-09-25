import 'package:flutter/material.dart';

import '../../config/const.dart';

class CustomFormField extends StatefulWidget {
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final int? maxLines;
  final bool obscureText;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final Function(String?)? onChanged;
  final Function()? suffixIconOnPressed;
  final TextInputAction? textInputAction;
  final bool? autoFocus;
  final Function()? onEditComplete;
  final double? contentPadding;
  final bool? enabled;
  const CustomFormField({
    Key? key,
    this.enabled = true,
    this.maxLines = 1,
    this.contentPadding = 0,
    this.suffixIconOnPressed,
    this.suffixIcon,
    required this.hintText,
    this.prefixIcon,
    this.autoFocus,
    this.validator,
    this.onEditComplete,
    this.onSaved,
    this.textInputAction,
    required this.obscureText,
    required this.textEditingController,
    required this.textInputType,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: widget.maxLines! * 70,
        maxWidth: 400,
      ),
      child: TextFormField(
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        onEditingComplete: widget.onEditComplete,
        autofocus: widget.autoFocus ?? false,
        textInputAction: widget.textInputAction,
        onChanged: widget.onChanged,
        autocorrect: false,
        enableSuggestions: false,
        style: TextStyle(
            color: Theme.of(context).primaryColor, fontSize: Sizes.fontSize14),
        cursorColor: Theme.of(context).primaryColor,
        keyboardType: widget.textInputType,
        onSaved: widget.onSaved,
        validator: widget.validator,
        obscureText: widget.obscureText,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
        controller: widget.textEditingController,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: widget.contentPadding ?? 0),
            hintText: widget.hintText,
            prefixIcon: Icon(
              widget.prefixIcon,
            ),
            suffixIcon: IconButton(
              onPressed: widget.suffixIconOnPressed,
              icon: Icon(widget.suffixIcon),
            )),
      ),
    );
  }
}
