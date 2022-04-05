import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String title;
  final FocusNode? focusNode;
  final String hintTitle;
  final int maxLines;
  final bool readOnly;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  const CustomInputField({
    Key? key,
    required this.controller,
    required this.title,
    required this.hintTitle,
    this.focusNode,
    this.validator,
    this.readOnly = false,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            focusNode: focusNode,
            readOnly: readOnly,
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              contentPadding: maxLines == 1
                  ? const EdgeInsets.only(left: 16)
                  : const EdgeInsets.all(16),
              hintText: hintTitle,
              hintStyle: Theme.of(context).textTheme.bodySmall,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
