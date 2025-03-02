// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:piduiteun/widgets/text_widget.dart';

class TextFieldWithTitleWidget extends StatelessWidget {
  const TextFieldWithTitleWidget({
    required this.title, 
    required this.textEditingController, 
    required this.errorMessage, 
    required this.hint, 
    this.isCurrency = false,
    this.textInputType = TextInputType.text,
    this.isEnabled = true,
    this.prefix,
    super.key,
  });
  final String title;
  final TextEditingController textEditingController;
  final String hint;
  final String errorMessage;
  final bool isCurrency;
  final TextInputType textInputType;
  final bool isEnabled;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: title,
          size: 14.sp,
          weight: FontWeight.w500,
        ),
        SizedBox(height: 4.h,),
        TextFormField(
          autocorrect: false,
          enabled: isEnabled,
          keyboardType: textInputType,
          controller: textEditingController,
          validator: (value) => value == null || value.isEmpty ? 
            errorMessage : 
            null,
          inputFormatters: [
            if (isCurrency)
              CurrencyTextInputFormatter(
                NumberFormat.currency(
                  locale: 'id', 
                  decimalDigits: 0,
                  symbol: '',
                ),
              ),
          ],
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(
              isCurrency ? 0.w : 12.w , 12.h, 12.w, 12.h,
            ),
            filled: true,
            fillColor: const Color.fromRGBO(223, 228, 218, 1),
            hintText: hint,
            prefixIcon: prefix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
