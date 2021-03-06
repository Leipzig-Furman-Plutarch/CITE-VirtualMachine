#  A Tour of CITE/CTS

**Leipzig-Furman Collaboration: virtualMachine2017**

## CITE-App

A single-page application for browsing libraries in `.cex` format is online at: <http://192.168.33.10/cite.html>

By default, it loads a sample `.cex` file with texts in Greek, Latin, English, Pesian, Arabic, and German. Other `.cex` libraries may be found at <https://github.com/cite-architecture/citedx>, which is checked out into this virtual machine at `/vagrant/citedx`.

## CiteServlet2

**CiteServlet2** (**cs2**) is a JVM server application written in [Groovy](http://groovy-lang.org) and using [Apache Jena Fuseki](https://jena.apache.org/documentation/serving_data/) as a datastore. Text and collection data is encoded as RDF statements in `.ttl` format.

These links assume the `cts-demo-corpus` texts (loaded by default into this Virtual Machine). This demonstration library consists of 22,000,000 RDF statements, serving a variety of texts and collections, as a demonstration of CITE.

**Instructions for loading alternate datasets are in the file [“Using CS2 With Your Own Data”](/dev/null).**

### CS2 Tour: Basics

- [CS2 CTS Home](http://192.168.33.10/cs2/ctshome)
- [CS2 CITE Collections Home](http://192.168.33.10/cs2/cchome)
- [CS2 CITE Image Extension Home](http://192.168.33.10/cs2/imghome)


### CS2 Tour: Demo Text Corpus

- Request: `GetCapabilities`. See the holdings of the CTS library. Unstyled XML.

> <http://192.168.33.10/cs2/texts?request=GetCapabilities>

- Request: `GetCapabilities`, parameter `stylesheet` = "cts_capabilities". See the holdings of the CTS library. Stylesheet added.

> SparqlCTS looks for XSLT stylsheets in `../cs2/sparqlcts/src/main/webapp/cts-ui/xslt/`.

> <http://192.168.33.10/cs2/texts?request=GetCapabilities&stylesheet=cts_capabilities>

- Request: `GetPassage`. XML output, *Iliad* 1.1-1.10.

> <http://192.168.33.10/cs2/texts?request=GetPassage&urn=urn:cts:greekLit:tlg0012.tlg001.fuPers:1.1-1.10>

- Request: `GetPassagePlus`. XML output, *Iliad* 1.1-1.10, the passage and additional information useful for constructing a browsing application.

> <http://192.168.33.10/cs2/texts?request=GetPassagePlus&urn=urn:cts:greekLit:tlg0012.tlg001.fuPers:1.1-1.10>

- Request: `GetPassage`, parameter `stylesheet` = "cts_passage". Styled output for *Iliad* 1.1-1.10.

> <http://192.168.33.10/cs2/texts?request=GetPassage&stylesheet=cts_passage&urn=urn:cts:greekLit:tlg0012.tlg001.fuPers:1.1-1.10>

- Request: `GetPassagePlus`, parameter `stylesheet` = "cts_passage". Styled output for *Iliad* 1.1-1.10.

> <http://192.168.33.10/cs2/texts?request=GetPassagePlus&stylesheet=cts_passage&urn=urn:cts:greeklit:tlg0012.tlg001.fuPers:1.1-1.10>

> This implementation will look for stylesheets in `../cs2/sparqlct/src/main/webapp/cts-ui/xslt/`.

- Request: `GetPassagePlus`, parameter `stylesheet` = "cts_cat". Styled output for *iliad* 1.1-1.10, showing how to use a stylesheet to build an application.

> The stylesheet `cts-cat.xsl` calls on CSS and Javascript resources in `../cs2/sparqlcts/src/main/webapp/cts-ui/`.

> <http://192.168.33.10/cs2/texts?request=GetPassagePlus&stylesheet=cts_cat&urn=urn:cts:greekLit:tlg0012.tlg001.fuPers:1.1-1.10>


- Request: `GetValidReff`, parameter `stylesheet` = "cts_validreff". Styled output showing every valid citation for *Iliad* Book 1 (in the "fuPers" edition).

> <http://192.168.33.10/cs2/texts?request=GetValidReff&stylesheet=cts_validreff&urn=urn:cts:greekLit:tlg0012.tlg001.fuPers:1>

- Request: `GetValidReff`, parameter `level` = "1", parameter `stylesheet` = "cts_validreff". Styled output showing every valid 1-level deep citation for the *Iliad*(in the "fuPers" edition).

> <http://192.168.33.10/cs2/texts?request=GetValidReff&stylesheet=cts_validreff&level=1&urn=urn:cts:greekLit:tlg0012.tlg001.fuPers:>

- Request: `GetValidReff`, parameter `level` = "2", parameter `stylesheet` = "cts_validreff". Styled output showing every valid 2-level deep citation in the range 1.600-2.25 for the *Iliad* (in the "fuPers" edition).

> <http://192.168.33.10/cs2/texts?request=GetValidReff&stylesheet=cts_validreff&level=2&urn=urn:cts:greekLit:tlg0012.tlg001.fuPers:1.600-2.25>

### URL Rewriting

This virtual machine, at configuration-time, loaded an apache2 configuration file (`/vagrant/system/apache2-cite-proxy.conf`) to do some URL-rewriting, as a demonstration. Setup for this is best seen by looking at `/vagrant/system/bootstrap.sh`.

**Why do I care?** This lets you create `HTTP-URI`s out of `CTS-URN`s. That is, URLs that combine a service's *location* with an object's *identifier*.

- Request: `GetPassage`. Plain XML output from HTTP-URI, via URL rewriting. **Iliad** 1.1-1.10.

> <http://192.168.33.10/cts/gp/urn:cts:greekLit:tlg0012.tlg001.fuPers:1.1-1.10>

- Request: `GetValidReff`. Plain XML output from HTTP-URI, via URL rewriting. Valid citations for *Iliad* 1.

> <http://192.168.33.10/cts/gvr/urn:cts:greekLit:tlg0012.tlg001.fuPers:1>

### CS2 Tour: Collections and Images

For these, if you have followed along this far, you can remove the `&stylesheet=…` part to see unstyled XML.

- CITE Collection: `GetCapabilities`. See what collections are available.

> <http://192.168.33.10/cs2/collections?request=GetCapabilities&stylesheet=cite_capabilities&inv=collections.xml>

- CITE Image Extension: `GetExtendedCollections`. See which of the available Collections are exteded by CITE-Image.

> <http://192.168.33.10/cs2/images?request=GetExtendedCollections&stylesheet=cite_collections>

- CITE Image Extension: `GetObjectPlus`. A request to the CITE Collection service for an object extended by CITE-Image. 

> <http://192.168.33.10/cs2/collections?request=GetObjectPlus&stylesheet=cite_getobject&urn=urn:cite2:hmt:vaimg.v1:VA012RN_0013>

- CITE Image Extension. The **Image Citation Tool**. Define URNs with Region-of-interest sub-references. Use the `See Selection` and `Selection in Context` links to see what happens with a URN+Subreference gets passed to the CITE Image Service.

> <http://192.168.33.10/cs2/ict.html?urn=urn:cite2:hmt:vaimg.v1:VA012RN_0013>

- CITE Collection Service. See valid URNs for a Collection whose Objects share a property that is, itself, a URN to an Image Collection. Click on any of the listed objects to see how this integrated service handles these things.

> <http://192.168.33.10/cs2/collections?request=GetValidReff&safemode=on&stylesheet=cite_getvalidreff&urn=urn:cite2:hmt:pageroi.v1:>
