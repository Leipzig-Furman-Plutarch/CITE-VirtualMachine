#!/usr/bin/env /bin/bash

echo "-----------------------------------"
echo "Navigate to the citemgr directory…"
echo ""
echo "   cd /vagrant/cite-archive-manager"
echo ""
cd /vagrant/cite-archive-manager
echo "-----------------------------------"
echo "Copying the configuration file for bulding the CTS Test Data here…"
echo ""

cp /vagrant/scripts/citemgr-cts-demo.gradle .
cp /vagrant/scripts/all-conf.gradle .

echo "-----------------------------------"
echo "Rename that file 'conf.gradle.'"
echo ""
echo "   cp citemgr-cts-demo.gradle conf.gradle"
echo ""
#cp citemgr-cts-demo.gradle conf.gradle
cp all-conf.gradle conf.gradle
echo "-----------------------------------"
echo "Run the 'clean' task to prepare Gradle…"
echo ""
echo "   gradle clean"
echo ""

gradle clean

echo "-----------------------------------"
echo "Run the CITE Manager 'ttl' task in Gradle to process the XML files, using a TextInventory and Citation Config file, into tabular representations of texts, and then into a single '.ttl' file expressing the corpus as RDF statement. This will take some time."
echo ""
echo "   gradle ttl"
echo ""
gradle ttl
echo "-----------------------------------"
echo "Copying the resulting files, 'cts.tll', 'collections.ttl', and 'images.ttl', into 'vagrant/data/' for safekeeping."
echo ""
echo "    cp /vagrant/citemgr/projects/build/ttl/corpus.ttl /vagrant/data/cts-demo.ttl"
echo ""
cp /vagrant/cite-archive-manager/build/ttl/cts.ttl /vagrant/data/cts-demo.ttl
cp /vagrant/cite-archive-manager/build/ttl/citeimgs.ttll /vagrant/data/cite-imgs.ttl
cp /vagrant/cite-archive-manager/build/ttl/cts.ttl /vagrant/data/collections.ttl
echo "-----------------------------------"
echo "Moving the TextInventory file cataloging this test data into place."
echo ""

cp /vagrant/cts-demo-corpus/inventory.xml /vagrant/cs2/sparqlcts/src/main/webapp/invs/inventory.xml

echo "-----------------------------------"
echo "Done!"
