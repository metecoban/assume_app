/// Returns [String name, String surname] or null
List<String>? fullNameParser(String name) {
  final whitespaceRE = RegExp(r"\s+");
  List<String> nameTextControl =
      name.replaceAll(whitespaceRE, " ").trim().split(' ');

  if (nameTextControl.length >= 2) {
    int count = nameTextControl.length - 1;
    String name = nameTextControl.reduce((f, s) {
      if (s != nameTextControl[count]) return '$f $s';
      return f;
    });

    String surname = nameTextControl[count];
    return [name, surname];
  }

  return null;
}
