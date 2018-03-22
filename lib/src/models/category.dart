import 'package:xml/xml.dart' as xml;

class Category {
  final String term;
  final String scheme;
  final String label;

  Category(
    this.term, {
    this.scheme,
    this.label,
  });

  factory Category.fromXml(xml.XmlElement node) {
    // Mandatory fields:
    String term;
    try {
      term = node.getAttribute("term");
    } catch (e) {
      throw new ArgumentError('Category missing mandatory term element');
    }

    // Optional fields:
    String scheme;
    try {
      scheme = node.getAttribute("scheme");
    } catch (e) {}

    String label;
    try {
      label = node.getAttribute("label");
    } catch (e) {}

    return new Category(
      term,
      scheme: scheme,
      label: label,
    );
  }

  String toString() {
    return '''
      term: $term
      scheme: $scheme
      label: $label
    ''';
  }
}
