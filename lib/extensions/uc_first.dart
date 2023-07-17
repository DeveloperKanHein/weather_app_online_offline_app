extension StringExtension on String {
  String ucFirst() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}