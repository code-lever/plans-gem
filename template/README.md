# Plans templates for code lever.

This project contains the following document templates. 

* [Vision and Scope](./scope)
* [Functional Specifications](./functional)
* [User Classes and Characteristics](./users)
* [Glossary](./glossary)
* [Plain Document](./doc)

Templates are composed of a folder containing a few documents. The first is the initial version of the markdown document. This document is named *README.md*. The second is the reference document, named *reference.docx*. This is the word file used by Pandoc for style information publishing the document.

## README.md

When you create a new document based on this template, this file will be copied to the new document location to be used as a starting point.

## reference.docx

When you render the markdown document into MS Word, the styles, headers and footers of the reference.docx will be used as the basis for the published document. Modify the reference.docx to change the look and feel of the rendered document. You can, for example, add images to the header for a company logo.

From [pandoc.org](http://pandoc.org/README.html)

> Use the specified file as a style reference in producing a docx file. For best results, the reference docx should be a modified version of a docx file produced using pandoc. The contents of the reference docx are ignored, but its stylesheets and document properties (including margins, page size, header, and footer) are used in the new docx. If no reference docx is specified on the command line, pandoc will look for a file reference.docx in the user data directory (see --data-dir). If this is not found either, sensible defaults will be used. The following styles are used by pandoc: [paragraph] Normal, Body Text, First Paragraph, Compact, Title, Subtitle, Author, Date, Abstract, Bibliography, Heading 1, Heading 2, Heading 3, Heading 4, Heading 5, Heading 6, Block Text, Footnote Text, Definition Term, Definition, Caption, Table Caption, Image Caption, Figure, Figure With Caption, TOC Heading; [character] Default Paragraph Font, Body Text Char, Verbatim Char, Footnote Reference, Hyperlink; [table] Normal Table.

You can modify the document styles and add items to the headers and footers of the *reference.docx* to customize the output. One thing to note, Pandoc seems to work best if the document is blank, so clear any text in the *reference.docx* before using it.

## template.yml

Metadata for the template.

    # The longer title of the document
    # Used help for plans.
    title: User Classes and Characteristics

    # A description of the document
    # Used by help for plans.
    description: A list of all of the users and their major characteristics. These users should be referenced by the Vision and Scope document and any associated Functional Specifications.

Note that the name of the document used by plans is the name of the folder. To create the *User Classes and Characteristics* document above, you would enter the command `plans create user`.
