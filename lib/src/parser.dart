import 'package:xml/xml.dart' as xml;

import 'models.dart';

/// Parses the provided input string into a [AtomFeed] object
/// Throws if [feedString] is not a valid xml string.
///
/// The parser is lenient by default ([strict] is `false`), initializing missing
/// fields to `null`.
///
/// Setting [strict] to `true` will throw an [ArgumentError] when one of the
/// mandatory Atom 1.0 properties is missing:

AtomFeed parse(String feedString, {bool strict = false}) {
  try {
    xml.XmlDocument document = xml.parse(feedString);

    xml.XmlElement feedElement = document.rootElement;

    AtomFeed feed = new AtomFeed.fromXml(feedElement, strict);

    return feed;
  } catch (e) {
    rethrow;
  }
}
