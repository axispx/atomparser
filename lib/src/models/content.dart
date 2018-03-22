import 'package:xml/xml.dart' as xml;

class Content {
  final String text;
  final String type;
  final String url;

  Content(
    this.text, {
    this.type,
    this.url,
  });

  factory Content.fromXml(xml.XmlElement node) {
    String text = '';
    try {
      text = node.text;
    } catch (e) {}

    String type;
    try {
      type = node.getAttribute("type");
    } catch (e) {}

    String url;
    try {
      url = node.getAttribute("url");
    } catch (e) {}

    return new Content(
      text,
      type: type,
      url: url,
    );
  }

  String toString() {
    return '''
      text: $text
      type: $type
      url: $url
    ''';
  }
}
