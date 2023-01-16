extension NumberParsing on String? {
  bool isValidUrl() {
    if (this == null)
      return false;
    else
      return Uri.parse(this!).isAbsolute;
  }
}
