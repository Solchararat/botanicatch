import 'package:botanicatch/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Color? fillColor;
  final Color? focusColor;
  final String? Function(String?) validator;
  final bool? obscureText;
  const CustomTextFormField(
      {super.key,
      this.hintText,
      this.controller,
      this.obscureText,
      required this.validator,
      this.fillColor = kGrayColor200,
      this.focusColor = kGrayColor200});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late final FocusNode _focusNode;
  late final ValueNotifier<bool> _focusNotifier;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNotifier = ValueNotifier(false);
    _focusNode.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _focusNotifier.dispose();
    super.dispose();
  }

  void _onFocusChange() => _focusNotifier.value = _focusNode.hasFocus;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _focusNotifier,
        builder: (BuildContext _, bool isFocus, Widget? child) {
          return TextSelectionTheme(
              data: const TextSelectionThemeData(
                  selectionHandleColor: kGreenColor300),
              child: TextFormField(
                obscureText: widget.obscureText ?? false,
                validator: widget.validator,
                controller: widget.controller,
                style: kSmallTextStyle.copyWith(color: kGrayColor200),
                cursorColor: kGreenColor300,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isFocus ? widget.focusColor : widget.fillColor,
                  hintText: widget.hintText,
                  hintStyle: kSmallTextStyle.copyWith(color: kGrayColor200),
                  enabledBorder: kOutlineInputBorder,
                  focusedBorder: kOutlineInputBorder,
                  errorBorder: kOutlineInputBorder,
                  focusedErrorBorder: kOutlineInputBorder,
                ),
              ));
        });
  }
}
