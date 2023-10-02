import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piduiteun/widgets/text_widget.dart';

class InExContainerDataWidget extends StatelessWidget {
  const InExContainerDataWidget({
    required this.title, 
    required this.money, 
    required this.isIncome, 
    super.key,
  });

  final String title;
  final String money;
  final bool isIncome;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: Icon(
              isIncome ? 
              Icons.arrow_upward_rounded : 
              Icons.arrow_downward_rounded,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          SizedBox(width: 16.w,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: title,
                weight: FontWeight.w600,
                size: 14.sp,
              ),
              CustomTextWidget(
                text: 'Rp.$money',
                weight: FontWeight.w600,
                size: 14.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
