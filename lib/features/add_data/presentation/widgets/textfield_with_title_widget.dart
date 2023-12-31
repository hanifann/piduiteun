import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    super.key,
  });
  final String title;
  final TextEditingController textEditingController;
  final String hint;
  final String errorMessage;
  final bool isCurrency;
  final TextInputType textInputType;
  final bool isEnabled;

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
        Row(
          children: [
            Visibility(
              // ignore: avoid_bool_literals_in_conditional_expressions
              visible: isCurrency ? true : false,
              child: Container(
                padding: EdgeInsets.only(left: 8.w),
                height: 58.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(223, 228, 218, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    bottomLeft: Radius.circular(8.r),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.h, horizontal: 12.w,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(210, 215, 200, 1),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: const Text('Rp.'),
                ),
              ),
            ),
            Flexible(
              child: TextFormField(
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
                        locale: 'id', 
                        decimalDigits: 0,
                        symbol: '',
                      ),
                ],
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(223, 228, 218, 1),
                  hintText: hint,
                  border: OutlineInputBorder(
                    borderRadius: isCurrency ? BorderRadius.only(
                      topRight: Radius.circular(8.r),
                      bottomRight: Radius.circular(8.r),
                    ) : BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
