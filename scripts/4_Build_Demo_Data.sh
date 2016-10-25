#!/usr/bin/env /bin/bash

echo "-----------------------------------"
echo "Navigate to the citemgr directory…"
echo ""
echo "   cd /vagrant/cite-archive-manager"
echo ""
cd /vagrant/cite-archive-manager
echo "-----------------------------------"
echo "Copy the configuration file for bulding the CTS Test Data here…"
echo ""
echo "   cp /vagrant/scripts/citemgr-cts-demo.gradle ."
echo ""
cp /vagrant/scripts/citemgr-cts-demo.gradle .
echo "-----------------------------------"
echo "Rename that file 'conf.gradle.'"
echo ""
echo "   cp citemgr-cts-demo.gradle conf.gradle"
echo ""
cp citemgr-cts-demo.gradle conf.gradle 
echo "-----------------------------------"
echo "Run the 'clean' task to prepare Gradle…"
echo ""
echo "   gradle clean"
echo ""
gradle clean
echo "-----------------------------------"
echo "Run the CITE Manager 'ctsttl' task in Gradle to process the XML files, using a TextInventory and Citaition Config file, into tabular representations of texts, and then into a single '.ttl' file expressing the corpus as RDF statement. This will take some time."
echo ""
echo "   gradle ctsttl"
echo ""
gradle ctsttl
echo "-----------------------------------"
echo "Copy the resulting file, 'corpus.tll', into 'vagrant/data/' as 'cts-test.ttl', for safekeeping."
echo ""
echo "    cp /vagrant/citemgr/projects/build/ttl/corpus.ttl /vagrant/data/cts-demo.ttl"
echo ""
cp /vagrant/cite-archive-manager/build/ttl/cts.ttl /vagrant/data/cts-demo.ttl
echo "-----------------------------------"
echo "Move the TextInventory file cataloging this test data into place."
echo ""
echo "   cp /vagrant/cts-demo-corpus/inventory.xml /vagrant/cs2/sparqlcts/src/main/webapp/invs/inventory.xml"
echo ""
cp /vagrant/cts-demo-corpus/inventory.xml /vagrant/cs2/sparqlcts/src/main/webapp/invs/inventory.xml
echo "-----------------------------------"
echo "Done!"
