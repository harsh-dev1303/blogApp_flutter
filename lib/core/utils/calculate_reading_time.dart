int CalculateReadingTime(String content){
  final wordCount = content.split(RegExp(r'\s+')).length;

  final readingTime = wordCount/225;

  print("reading time: ${readingTime.ceil()}");
  return readingTime.ceil();
}