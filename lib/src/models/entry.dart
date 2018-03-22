import 'package:xml/xml.dart' as xml;

import 'person.dart';
import 'text.dart';
import 'link.dart';
import 'category.dart';
import 'content.dart';

class Entry {
  final String id;
  final DocumentText title;
  final String updated;
  final Person author;
  final Content content;
  final Link link;
  final DocumentText summary;
  final Category category;
  final String published;
  final DocumentText rights;

  Entry(
    this.id,
    this.title,
    this.updated, {
    this.author,
    this.content,
    this.link,
    this.summary,
    this.category,
    this.published,
    this.rights,
  });

  factory Entry.fromXml(xml.XmlElement node, bool strict) {
    // Mandatory Fields
    String id;
    try {
      id = node.findElements('id').single.text;
    } catch (e) {
      if (strict) {
        throw new ArgumentError('Entry missing mandatory id element');
      }
    }

    DocumentText title;
    try {
      var titleElement = node.findElements('title').single;
      title = new DocumentText.fromXml(titleElement);
    } catch (e) {
      if (strict) {
        throw new ArgumentError('Entry missing mandatory title element');
      }
    }

    String updated;
    try {
      updated = node.findElements('updated').single.text;
    } catch (e) {
      if (strict) {
        throw new ArgumentError('Entry missing mandatory updated element');
      }
    }

    // Optional fields:
    xml.XmlElement authorElement;
    try {
      authorElement = node.findElements('author').single;
    } catch (e) {}
    Person author;
    if (authorElement != null) {
      author = new Person.fromXml(authorElement);
    }

    Content content;
    try {
      var contentElement = node.findElements('content').single;
      content = new Content.fromXml(contentElement);
    } catch (e) {}

    Link link;
    try {
      var linkElement = node.findElements('link').single;
      link = new Link.fromXml(linkElement);
    } catch (e) {}

    DocumentText summary;
    try {
      var summaryElement = node.findElements('summary').single;
      summary = new DocumentText.fromXml(summaryElement);
    } catch (e) {}

    Category category;
    try {
      var categoryElement = node.findElements('category').single;
      category = new Category.fromXml(categoryElement);
    } catch (e) {}

    String published;
    try {
      published = node.findElements('published').single.text;
    } catch (e) {}

    DocumentText rights;
    try {
      var rightsElement = node.findElements('rights').single;
      rights = new DocumentText.fromXml(rightsElement);
    } catch (e) {}

    return new Entry(
      id,
      title,
      updated,
      author: author,
      content: content,
      link: link,
      summary: summary,
      category: category,
      published: published,
      rights: rights,
    );
  }

  String toString() {
    return '''
      id: $id
      title: $title
      updated: $updated
      author: $author
      content: $content
      link: $link
      summary: $summary
      category: $category
      published: $published
      rights: $rights
    ''';
  }
}