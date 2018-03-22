import 'package:test/test.dart';

import 'package:atomparser/atomparser.dart';
import 'package:atomparser/src/models/person.dart';
import 'package:atomparser/src/models/entry.dart';
import 'package:atomparser/src/models/link.dart';
import 'package:atomparser/src/models/text.dart';
import 'package:atomparser/src/models/category.dart';
import 'package:atomparser/src/models/content.dart';

void main() {
  test('Empty string throws ArgumentError', () {
    expect(() => parse(''), throwsArgumentError);
  });

  test('Malformed XML throws ArgumentError', () {
    String malformedXML = r'''
      <?xml version="1.0" encoding="UTF-8"?>
      <feed xmlns="http://www.w3.org/2005/Atom">
      <
    ''';

    expect(() => parse(malformedXML), throwsArgumentError);
  });

  group('Strict Mode', () {
    test('Throws ArgumentError if feed id missing', () {
      String data = r'''
        <?xml version="1.0" encoding="utf-8"?>
        <feed xmlns="http://www.w3.org/2005/Atom">

          <title>feedTitle</title>
          <link href="feedLink"/>
          <updated>2003-12-13T18:30:02Z</updated>
          <author>
            <name>authorName</name>
          </author>

        </feed>
      ''';

      expect(() => parse(data, strict: true), throwsArgumentError);
    });

    test('Throws ArgumentError if feed title missing', () {
      String data = r'''
        <?xml version="1.0" encoding="utf-8"?>
        <feed xmlns="http://www.w3.org/2005/Atom">

          <link href="feedLink"/>
          <updated>2003-12-13T18:30:02Z</updated>
          <author>
            <name>authorName</name>
          </author>
          <id>feedID</id>

        </feed>
      ''';
      expect(() => parse(data, strict: true), throwsArgumentError);
    });

    test('Throws ArgumentError if feed updated missing', () {
      String data = r'''
        <?xml version="1.0" encoding="utf-8"?>
        <feed xmlns="http://www.w3.org/2005/Atom">

          <title>feedTitle</title>
          <link href="feedLink"/>
          <author>
            <name>authorName</name>
          </author>
          <id>feedID</id>

        </feed>
      ''';

      expect(() => parse(data, strict: true), throwsArgumentError);
    });

    test('Throws ArgumentError if feed link missing', () {
      String data = r'''
        <?xml version="1.0" encoding="utf-8"?>
        <feed xmlns="http://www.w3.org/2005/Atom">

          <title>feedTitle</title>
          <updated>2003-12-13T18:30:02Z</updated>
          <author>
            <name>authorName</name>
          </author>
          <id>feedID</id>

        </feed>
      ''';

      expect(() => parse(data, strict: true), throwsArgumentError);
    });
  });

  test('Parses a Feed with all possible fields', () {
    String data = r'''
      <?xml version="1.0" encoding="utf-8"?>
      <feed xmlns="http://www.w3.org/2005/Atom">

        <title type="text">feedTitle</title>
        <link href="feedSelfLink" rel="self"/>
        <link href="feedLink"/>
        <updated>2003-12-13T18:30:02Z</updated>
        <author>
          <name>authorName</name>
          <uri>authorUri</uri>
          <email>authorEmail</email>
        </author>

        <id>feedID</id>
        <category term="feedCategory" />
        <icon>feedIcon</icon>
        <logo>feedLogo</logo>
        <rights type="html">feedRights</rights>
        <subtitle>feedSubtitle</subtitle>

        <entry>
          <id>entryID</id>
          <title type="text">entryTitle</title>
          <updated>2003-12-13T18:30:02Z</updated>
          <author>
            <name>entryAuthorName</name>
            <uri>entryAuthorUri</uri>
            <email>entryAuthorEmail</email>
          </author>
          <link href="entryLink"/>
          <content type="html">entryContent</content>
          <summary type="text">entrySummary</summary>
          <category term="entryCategory" label="categoryLabel" />
          <published>2003-12-13T18:30:02Z</published>
          <rights type="html">entryRights</rights>
        </entry>

      </feed>
    ''';

    AtomFeed expected = new AtomFeed(
      'feedID',
      'feedTitle',
      '2003-12-13T18:30:02Z',
      <Link>[
        new Link(
          "feedSelfLink",
          rel: "self",
        ),
        new Link(
          "feedLink",
        )
      ],
      authors: <Person>[
        new Person(
          "authorName",
          uri: "authorUri",
          email: "authorEmail",
        )
      ],
      category: new Category(
        "feedCategory",
      ),
      icon: "feedIcon",
      logo: "feedLogo",
      rights: new DocumentText("feedRights", type: "html"),
      subtitle: "feedSubtitle",
      entries: <Entry>[
        new Entry(
            "entryID",
            new DocumentText(
              "entryTitle",
              type: "text",
            ),
            "2003-12-13T18:30:02Z",
            author: new Person(
              "entryAuthorName",
              uri: "entryAuthorUri",
              email: "entryAuthorEmail",
            ),
            content: new Content("entryContent", type: "html"),
            link: new Link(
              "entryLink",
            ),
            summary: new DocumentText(
              "entrySummary",
              type: "text",
            ),
            category: new Category(
              "entryCategory",
              label: "categoryLabel",
            ),
            published: "2003-12-13T18:30:02Z",
            rights: new DocumentText(
              "entryRights",
              type: "html",
            ))
      ],
    );

    AtomFeed result = parse(data);

    expect(result.id, expected.id);
    expect(result.title, expected.title);
    expect(result.updated, expected.updated);
    expect(result.links[0].href, expected.links[0].href);
    expect(result.links[0].rel, expected.links[0].rel);
    expect(result.links[1].href, expected.links[1].href);
    expect(result.authors[0].name, expected.authors[0].name);
    expect(result.authors[0].uri, expected.authors[0].uri);
    expect(result.authors[0].email, expected.authors[0].email);
    expect(result.authors[0].uri, expected.authors[0].uri);
    expect(result.authors[0].email, expected.authors[0].email);
    expect(result.category.term, expected.category.term);
    expect(result.icon, expected.icon);
    expect(result.logo, expected.logo);
    expect(result.rights.text, expected.rights.text);
    expect(result.rights.type, expected.rights.type);
    expect(result.subtitle, expected.subtitle);
    expect(result.entries.length, expected.entries.length);
    expect(result.entries[0].id, expected.entries[0].id);
    expect(result.entries[0].title.text, expected.entries[0].title.text);
    expect(result.entries[0].title.type, expected.entries[0].title.type);
    expect(result.entries[0].updated, expected.entries[0].updated);
    expect(result.entries[0].author.name, expected.entries[0].author.name);
    expect(result.entries[0].author.uri, expected.entries[0].author.uri);
    expect(result.entries[0].author.email, expected.entries[0].author.email);
    expect(result.entries[0].content.text, expected.entries[0].content.text);
    expect(result.entries[0].content.type, expected.entries[0].content.type);
    expect(result.entries[0].link.href, expected.entries[0].link.href);
    expect(result.entries[0].summary.text, expected.entries[0].summary.text);
    expect(result.entries[0].summary.type, expected.entries[0].summary.type);
    expect(result.entries[0].category.term, expected.entries[0].category.term);
    expect(
        result.entries[0].category.label, expected.entries[0].category.label);
    expect(result.entries[0].published, expected.entries[0].published);
    expect(result.entries[0].rights.text, expected.entries[0].rights.text);
    expect(result.entries[0].rights.type, expected.entries[0].rights.type);
  });
}
