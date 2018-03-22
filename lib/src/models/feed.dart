import 'package:xml/xml.dart' as xml;

import 'person.dart';
import 'entry.dart';
import 'link.dart';
import 'category.dart';
import 'text.dart';

class AtomFeed {
  final String id;
  final String title;
  final String updated;
  final List<Person> authors;
  final List<Link> links;
  final Category category;
  final String icon;
  final String logo;
  final DocumentText rights;
  final String subtitle;
  final List<Entry> entries;

  AtomFeed(
    this.id,
    this.title,
    this.updated,
    this.links, {
    this.authors,
    this.category,
    this.icon,
    this.logo,
    this.rights,
    this.subtitle,
    this.entries,
  });

  factory AtomFeed.fromXml(xml.XmlElement node, bool strict) {
    // Mandatory fields
    String id;
    try {
      id = node.findElements('id').single.text;
    } catch (e) {
      if (strict) {
        throw new ArgumentError('AtomFeed missing mandatory id element');
      }
    }

    String title;
    try {
      title = node.findElements('title').single.text;
    } catch (e) {
      if (strict) {
        throw new ArgumentError('AtomFeed missing mandatory title element');
      }
    }

    String updated;
    try {
      updated = node.findElements('updated').single.text;
    } catch (e) {
      if (strict) {
        throw new ArgumentError('AtomFeed missing mandatory updated element');
      }
    }

    List<Link> links = [];
    try {
      var linkElements = node.findElements('link');
      if (linkElements.isEmpty) throw ArgumentError;
      for (var link in linkElements) {
        links.add(new Link.fromXml(link));
      }
    } catch (e) {
      if (strict) {
        throw new ArgumentError(
            'AtomFeed missing mandatory link(s) element(s)');
      }
    }

    // Optional
    List<Person> authors = [];
    try {
      var authorElements = node.findElements('author');
      if (authorElements.isEmpty) throw ArgumentError;
      for (var author in authorElements) {
        authors.add(new Person.fromXml(author));
      }
    } catch (e) {}

    Category category;
    try {
      var categoryElement = node.findElements('category').single;
      category = new Category.fromXml(categoryElement);
    } catch (e) {}

    String icon;
    try {
      icon = node.findElements('icon').single.text;
    } catch (e) {}

    String logo;
    try {
      logo = node.findElements('logo').single.text;
    } catch (e) {}

    DocumentText rights;
    try {
      var rightsElement = node.findElements("rights").single;
      rights = new DocumentText.fromXml(rightsElement);
    } catch (e) {}

    String subtitle;
    try {
      subtitle = node.findElements('subtitle').single.text;
    } catch (e) {}

    List<Entry> entries = [];
    try {
      var entryElements = node.findElements('entry');
      if (entryElements.isEmpty) throw ArgumentError;
      for (var entryElement in entryElements) {
        entries.add(new Entry.fromXml(entryElement, strict));
      }
    } catch (e) {}

    return new AtomFeed(
      id,
      title,
      updated,
      links,
      authors: authors,
      category: category,
      icon: icon,
      logo: logo,
      rights: rights,
      subtitle: subtitle,
      entries: entries,
    );
  }

  String toString() {
    return '''
      id: $id
      title: $title
      updated: $updated
      authors: $authors
      links: $links
      category: $category
      icon: $icon
      logo: $logo
      rights: $rights
      subtitle: $subtitle
      entries: $entries
    ''';
  }
}
