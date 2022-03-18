extension FileExtensions on String {
  String fileExt() {
    return "." + split(".").last;
  }
}