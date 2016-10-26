#!/usr/bin/env /bin/bash

echo "-----------------------------------"
echo "Navigating to the citemgr directory…"
echo ""

cd /vagrant/cite-archive-manager

echo "-----------------------------------"
echo "Copying the configuration file for bulding the CTS Test Data here…"
echo ""

cp /vagrant/scripts/citemgr-cts-template.gradle .
cp citemgr-cts-template.gradle conf.gradle

echo "-----------------------------------"
echo "Running the 'clean' task to prepare Gradle…"
echo ""

gradle clean

echo "-----------------------------------"
echo "Running the CITE Manager 'ctsttl' task in Gradle to process the XML files, using a TextInventory and Citaition Config file, into tabular representations of texts, and then into a single '.ttl' file expressing the corpus as RDF statement. This will take some time."
echo ""

gradle ctsttl 

echo "-----------------------------------"
echo "Copying the resulting file, 'cts.tll', into 'vagrant/data/' as 'cts-template.ttl', for safekeeping."
echo ""

cp /vagrant/cite-archive-manager/build/ttl/cts.ttl /vagrant/data/cts-template.ttl

echo "-----------------------------------"
echo "Moving the TextInventory file cataloging this test data into place."
echo ""

cp /vagrant/cts-corpus-template/inventory.xml /vagrant/cs2/sparqlcts/src/main/webapp/invs/inventory.xml

echo "-----------------------------------"
echo "Done!"
