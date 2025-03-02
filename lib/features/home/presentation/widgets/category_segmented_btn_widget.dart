import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piduiteun/features/home/domain/entities/segmented_choice.dart';
import 'package:piduiteun/l10n/l10n.dart';

class CategorySegmentedBtnWidget extends StatelessWidget {
  const CategorySegmentedBtnWidget({
    required this.selectedValue, 
    required this.onSelectionChanged, 
    super.key,
  });

  final Set<SegmentedChoice> selectedValue;
  final void Function(Set<SegmentedChoice> value)? onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<SegmentedChoice>(
      segments: [
        ButtonSegment(
          value: SegmentedChoice.expense,
          label: Text(context.l10n.expenses),
        ),
        ButtonSegment(
          value:SegmentedChoice.income,
          label: Text(context.l10n.income),
        ),
      ], 
      showSelectedIcon: false,
      selected: selectedValue,
      onSelectionChanged: onSelectionChanged,
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }
}
