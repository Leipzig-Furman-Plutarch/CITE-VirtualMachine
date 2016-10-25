# CTS Corpus Template

A template for making a new CTS Corpus.

## Contents

- A TextInventory
- A Configuration File
- An XML Directory
- A Tabulated Files
- A RDF/TTL Directory

## Texts

This demonstration corpus includes two short texts as placeholders:

- Goethe, "Erlkönig". German.
- Goethe, "Erlkönig". English.

## Inventories

- The `inventory.xml` file is the CTS TextInventory cataloging the texts of this corpus. It valdates to `schemas/cts/TextInventory.rng`.
- The `citationconfig.xml` file provides information that the [CITE Manager](https://github.com/cite-architecture/citemgr) utility uses to process the XML files into tabular files and RDF statements. It validates to `schemas/cts/CitationConfiguration.rng`.

**Citation Scheme(s).** For this template, the `citationconfig.xml` file offers example configurations for citing this short poem in two different ways, either by *poetic line* (only), or by *stanza + poetic line*.

All texts in the corpus are catalogued in `inventory.xml`. 

## XML Files

The `XML` directory contains editions of the texts, valid according to the TEI P5 schema.

## Tabulated Files

Because CTS is based on a model of "text" as an "ordered hierarchy of citation objects", it is possible to instantiate a text differently for different purposes. The `Tabulated` directory contains transformations of the XML texts. These files contain one line for each citation-unit of the text. Each line contains records capturing citation-hierarchy, sequence, and text-content, delimited by the '#' character.

CiteManager will build these, but we include them here for reference.

## TTL-RDF

The `TTL-RDF` directory contains another expression of the texts in this archive, this time as a sequence of RDF statements describing every text in the corpus.

- `cts.ttl`. This is an RDF expression built from the tabular files in the `Tabulated` directory.

CiteManager will build this, but we include it here for reference.
