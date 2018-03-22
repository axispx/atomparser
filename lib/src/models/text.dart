import 'package:xml/xml.dart' as xml;

class DocumentText {
  final String text;
  final String type;

  DocumentText(this.text, {this.type = "text"});

  factory DocumentText.fromXml(xml.XmlElement node) {
    String text = '';
    try {
      text = node.text;
    } catch (e) {}

    String type;
    try {
      type = node.getAttribute("type");
    } catch (e) {}

    return new DocumentText(
      text,
      type: type,
    );
  }

  String toString() {
    return '''
      text: $text
      type: $type
    ''';
  }
}