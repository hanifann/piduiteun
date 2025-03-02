import 'package:flutter/widgets.dart';
import 'package:piduiteun/features/home/domain/entities/segmented_choice.dart';
import 'package:piduiteun/features/statistic/presentation/widgets/dropwodn_time_interval_widget.dart';
import 'package:piduiteun/l10n/l10n.dart';

extension TimeIntervalsExtension on TimeIntervals {
  String getLabel(BuildContext context) {
    final l10n = context.l10n;
    switch (this) {
      case TimeIntervals.weekly:
        return l10n.weekly;
      case TimeIntervals.monthly:
        return l10n.monthly;
      case TimeIntervals.yearly:
        return l10n.yearly;
    }
  }
}

extension SegmentedChoiceExtension on SegmentedChoice {
  String getLabel(BuildContext context) {
    final l10n = context.l10n;
    switch (this) {
      case SegmentedChoice.expense:
        return l10n.expenses;
      case SegmentedChoice.income:
        return l10n.income;
    }
  }
}
