import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;

  final String label;
  final void Function()? onEditingComplete;
  final bool autoFocus;
  final bool isTextArea;
  final bool isPassword;
  final bool denySpaces;
  final bool readOnly;
  final bool isOutlineBorder;
  final TextInputType keyboardType;
  final Widget? leadingWidget;
  final Widget? suffix;
  final double borderRadius;
  final void Function(String value)? onChanged;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  const CustomInput({
    super.key,
    required this.controller,
    this.focusNode,
    this.label = "",
    this.onEditingComplete,
    this.keyboardType = TextInputType.text,
    this.autoFocus = false,
    this.isTextArea = false,
    this.isPassword = false,
    this.denySpaces = false,
    this.readOnly = false,
    this.isOutlineBorder = true,
    this.leadingWidget,
    this.borderRadius = 30,
    this.suffix,
    this.onChanged,
    this.validator,
    this.autovalidateMode,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _isObscured = false;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autoFocus,
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      maxLines: widget.isTextArea ? 3 : 1,
      onEditingComplete: widget.onEditingComplete,
      autovalidateMode: widget.autovalidateMode,
      obscureText: _isObscured,
      readOnly: widget.readOnly,
      inputFormatters: [
        if (widget.denySpaces) FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      style: const TextStyle(fontSize: 15),
      onChanged: widget.onChanged,
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: widget.leadingWidget != null
                ? 0
                : widget.isOutlineBorder
                    ? 20
                    : 1),
        filled: widget.isOutlineBorder,
        fillColor: context.isDarkMode ? Colors.black12 : Colors.white,
        prefixIcon: widget.leadingWidget,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: _togglePasswordVisibility,
                child: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : widget.suffix,
        border: widget.isOutlineBorder
            ? const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(8)))
            : const UnderlineInputBorder(),
        hintText: widget.label,
      ),
    );
  }
}
