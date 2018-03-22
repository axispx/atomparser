import 'package:xml/xml.dart' as xml;

class Person {
  final String name;
  final String uri;
  final String email;

  Person(this.name, {this.uri, this.email});

  factory Person.fromXml(xml.XmlElement node) {
    // Mandatory fields:
    String name;
    try {
      name = node.findElements('name').single.text;
    } catch (e) {
      throw new ArgumentError('Person missing mandatory name element');
    }

    // Optional fields:
    String uri;
    try {
      uri = node.findElements('uri').single.text;
    } catch (e) {}

    String email;
    try {
      email = node.findElements('email').single.text;
    } catch (e) {}
    return new Person(name, uri: uri, email: email);
  }

  String toString() {
    return '''
      name: $name
      uri: $uri
      email: $email
    ''';
  }
}
