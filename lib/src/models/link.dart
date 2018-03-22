import 'package:xml/xml.dart' as xml;

class Link {
  final String href;
  final String rel;
  final String type;
  final String hreflang;
  final String title;
  final String length;

  Link(
    this.href, {
    this.rel,
    this.type,
    this.hreflang,
    this.title,
    this.length,
  });

  factory Link.fromXml(xml.XmlElement node) {
    // Mandatory fields:
    String href;
    try {
      href = node.getAttribute("href");
    } catch (e) {
      throw new ArgumentError('Link missing mandatory href element');
    }

    // Optional fields:
    String rel;
    try {
      rel = node.getAttribute("rel");
    } catch (e) {}

    String type;
    try {
      type = node.getAttribute("type");
    } catch (e) {}

    String hreflang;
    try {
      hreflang = node.getAttribute("hreflang");
    } catch (e) {}

    String title;
    try {
      title = node.getAttribute("title");
    } catch (e) {}

    String length;
    try {
      length = node.getAttribute("length");
    } catch (e) {}

    return new Link(
      href,
      rel: rel,
      type: type,
      hreflang: hreflang,
      title: title,
      length: length,
    );
  }

  String toString() {
    return '''
      href: $href
      rel: $rel
      type: $type
      hreflang: $hreflang
      title: $title
      length: $length
    ''';
  }
}
