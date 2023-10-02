import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piduiteun/features/home/domain/entities/segmented_choice.dart';

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
      segments: const [
        ButtonSegment(
          value: SegmentedChoice.pengeluaran,
          label: Text('Pengeluaran'),
        ),
        ButtonSegment(
          value:SegmentedChoice.pemasukan,
          label: Text('Pemasukan'),
        ),
      ], 
      showSelectedIcon: false,
      selected: selectedValue,
      onSelectionChanged: onSelectionChanged,
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }
}
