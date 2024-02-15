import 'package:flutter/material.dart';

enum TimeIntervals {
  weekly('Perminggu'),
  monthly('Perbulan'),
  yearly('Pertahun');

  const TimeIntervals(this.value);
  final String value;
}

class DropdownTimeIntervalWidget extends StatelessWidget {
  const DropdownTimeIntervalWidget({
    required this.controller, 
    required this.onSelected, 
    super.key,
  });

  final TextEditingController controller;
  final void Function(TimeIntervals? interval)? onSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<TimeIntervals>(
      controller: controller,
      initialSelection: TimeIntervals.monthly,
      onSelected: onSelected,
      dropdownMenuEntries: TimeIntervals.values
        .map<DropdownMenuEntry<TimeIntervals>>(
          (TimeIntervals intervals) {
            return DropdownMenuEntry<TimeIntervals>(
              value: intervals, 
              label: intervals.value,
            );
          }
      ).toList(),
      textStyle: Theme.of(context).textTheme.bodyMedium,
      trailingIcon: const Icon(Icons.keyboard_arrow_down),
      selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up),
      inputDecorationTheme:const InputDecorationTheme(
        isDense: true,
        border: InputBorder.none,
      ),
    );
  }
}
