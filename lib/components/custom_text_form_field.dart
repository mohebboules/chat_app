import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.onChanged,
      this.obsecureText = false});

  final String hintText;
  final Function(String)? onChanged;
  final bool obsecureText;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool obsecureText;
  @override
  void initState() {
    super.initState();
    obsecureText = widget.obsecureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText,
      validator: (data) {
        if (data == null || data.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        suffixIcon: widget.obsecureText == false
            ? null
            : IconButton(
                onPressed: () {
                  setState(() {
                    obsecureText = !obsecureText;
                  });
                },
                icon: Icon(
                  obsecureText
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: Colors.white,
                ),
              ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade800)),
      ),
    );
  }
}
