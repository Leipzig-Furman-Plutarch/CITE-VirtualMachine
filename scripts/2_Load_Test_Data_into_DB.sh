#!/usr/bin/env /bin/bash

echo "-----------------------------------"
echo "Navigating to where Gradle/Fuseki stores data files, specifically the 'ctsTest' data…"
echo ""
cd /vagrant/cs2/fuseki/fusekibase/databases/ctsTest
echo "-----------------------------------"
echo "Removing anything there, since we are loading new data…"
echo ""
rm *
echo "-----------------------------------"
echo "Using the 'tdbloader2' utility from Apache Jena to load our 'cts-test.ttl' file into a TDB Database…"
echo ""
/usr/bin/jena/bin/tdbloader2 --loc /vagrant/cs2/fuseki/fusekibase/databases/ctsTest /vagrant/data/cts-test.ttl
echo "-----------------------------------"
echo "Done!"



