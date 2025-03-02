String? capitalizeEachWords(String? text) {
  if (text == null) {
    return null;
  }

  if (text.length <= 1) {
    return text.toUpperCase();
  }

  // Split string into multiple words
  final words = text.toLowerCase().split(' ');

  // Capitalize first letter of each words
  final capitalizedWords = words.map((word) {
    if (word.trim().isNotEmpty) {
      final firstLetter = word.trim().substring(0, 1).toUpperCase();
      final remainingLetters = word.trim().substring(1);

      return '$firstLetter$remainingLetters';
    }
    return '';
  });

  // Join/Merge all words back to one String
  return capitalizedWords.join(' ');
}

extension CapitalizedStringExtension on String {
  String? toCapitalizeEachWords() {
    return capitalizeEachWords(this);
  }
  String truncateTo(int maxLength) =>
      (length <= maxLength) ? this : '${substring(0, maxLength)}...';
}
