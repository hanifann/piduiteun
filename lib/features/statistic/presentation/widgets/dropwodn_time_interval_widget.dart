import 'package:flutter/material.dart';
import 'package:piduiteun/core/utils/extensions/enum_extension.dart';

enum TimeIntervals {
  weekly,
  monthly,
  yearly;
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
              label: intervals.getLabel(context),
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
