# Example CTS Links

**Leipzig-Furman Collaboration: virtualMachine2016**

These links assume the `cts-demo-corpus` texts. They should serve as examples of using the CTS Protocol.

- Request: `GetCapabilities`. See the holdings of the CTS library. Unstyled XML.

> <http://192.168.33.10/cts/api?request=GetCapabilities>

- Request: `GetCapabilities`, parameter `stylesheet` = "cts_capabilities". See the holdings of the CTS library. Stylesheet added.

> SparqlCTS looks for XSLT stylsheets in `../cs2/sparqlcts/src/main/webapp/cts-ui/xslt/`.

> <http://192.168.33.10/cts/api?request=GetCapabilities&stylesheet=cts_capabilities>

- Request: `GetPassage`. XML output, *Iliad* 1.1-1.10.

> <http://192.168.33.10/cts/api?request=GetPassage&urn=urn:cts:greekLit:tlg0012.tlg001.fuPers:1.1-1.10>

- Request: `GetPassagePlus`. XML output, *Iliad* 1.1-1.10, the passage and additional information useful for constructing a browsing application.

> <http://192.168.33.10/cts/api?request=GetPassagePlus&urn=urn:cts:greekLit:tlg0012.tlg001.fuPers:1.1-1.10>

- Request: `GetPassage`, paremeter `stylesheet` = "cts_passage". Styled output for *Iliad* 1.1-1.10.

> <http://192.168.33.10/cts/api?request=GetPassage&stylesheet=cts_passage&urn=urn:cts:greekLit:tlg0012.tlg001.fuPers:1.1-1.10>

- Request: `GetPassagePlus`, paremeter `stylesheet` = "cts_passage". Styled output for *iliad* 1.1-1.10.

> <http://192.168.33.10/cts/api?request=getpassageplus&stylesheet=cts_passage&urn=urn:cts:greeklit:tlg0012.tlg001.fuPers:1.1-1.10>

> This implementation will look for stylesheets in `../cs2/sparqlct/src/main/webapp/cts-ui/xslt/`.

- Request: `GetPassagePlus`, paremeter `stylesheet` = "cts_cat". Styled output for *iliad* 1.1-1.10, showing how to use a stylesheet to build an application.

> The stylesheet `cts-cat.xsl` calls on CSS and Javascript resources in `../cs2/sparqlcts/src/main/webapp/cts-ui/`.

> <http://192.168.33.10/cts/api?request=GetPassagePlus&stylesheet=cts_cat&urn=urn:cts:greekLit:tlg0012.tlg001.fuPers:1.1-1.10>


- Request: `GetValidReff`, parameter `stylesheet` = "cts_validreff". Styled output showing every valid citation for *Iliad* Book 1 (in the "fuPers" edition).

> <http://192.168.33.10/cts/api?request=GetValidReff&stylesheet=cts_validreff&urn=urn:cts:greekLit:tlg0012.tlg001.fuPers:1>

- Request: `GetValidReff`, parameter `level` = "1", parameter `stylesheet` = "cts_validreff". Styled output showing every valid 1-level deep citation for the *Iliad*(in the "fuPers" edition).

> <http://192.168.33.10/cts/api?request=GetValidReff&stylesheet=cts_validreff&level=1&urn=urn:cts:greekLit:tlg0012.tlg001.fuPers:>

- Request: `GetValidReff`, parameter `level` = "2", parameter `stylesheet` = "cts_validreff". Styled output showing every valid 2-level deep citation in the range 1.600-2.25 for the *Iliad* (in the "fuPers" edition).

> <http://192.168.33.10/cts/api?request=GetValidReff&stylesheet=cts_validreff&level=2&urn=urn:cts:greekLit:tlg0012.tlg001.fuPers:1.600-2.25>

## URL Rewriting

- Request: `GetPassage`. Plain XML output from HTTP-URI, via URL rewriting. **Iliad** 1.1-1.10. 

> <http://192.168.33.10/cts/gp/urn:cts:greekLit:tlg0012.tlg001.fuPers:1.1-1.10>

- Request: `GetValidReff`. Plain XML output from HTTP-URI, via URL rewriting. Valid citations for *Iliad* 1.

> <http://192.168.33.10/cts/gvr/urn:cts:greekLit:tlg0012.tlg001.fuPers:1>

