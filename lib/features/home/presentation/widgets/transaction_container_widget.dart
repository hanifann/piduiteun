import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:piduiteun/widgets/text_widget.dart';

class TransactionContainerWidget extends StatelessWidget {
  const TransactionContainerWidget({
    required this.category, 
    required this.value, 
    required this.title,
    required this.dateTime, 
    this.isIncome = true,
    super.key,
  });

  final String category;
  final int value;
  final String title;
  final bool isIncome;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: Icon(categoryToIcons(category)),
        ),
        SizedBox(width: 12.w,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              text: title,
              size: 14.sp,
              weight: FontWeight.w500,
            ),
            CustomTextWidget(
              text: DateFormat('dd MMMM yyyy').format(dateTime),
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ],
        ),
        const Spacer(),
        CustomTextWidget(
          text: NumberFormat.currency(
            locale: 'id',
            symbol: 'Rp. ',
            decimalDigits: 0,
          ).format(value),
          size: 14.sp,
          weight: FontWeight.w500,
        ),
      ],
    );
  }

  IconData categoryToIcons(String category){
    switch (category) {
      case 'food':
        return Symbols.fastfood_rounded;
      case 'transportation':
        return Symbols.commute_rounded;
      case 'bills':
        return Symbols.payment_rounded;
      case 'etc':
        return Symbols.attach_money_rounded;
      case 'entertainment':
        return Symbols.sports_esports_rounded;
      default:
        return Symbols.savings_rounded;
    }
  }
}
